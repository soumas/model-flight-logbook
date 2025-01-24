#import os
from fastapi import BackgroundTasks
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig, MessageType
from config.configmanager import config
from utils.logger import log


smtpconf = None
if(config.smtp.server):
    smtpconf = ConnectionConfig(
        MAIL_USERNAME=config.smtp.username,
        MAIL_PASSWORD=config.smtp.password,
        MAIL_SERVER=config.smtp.server,
        MAIL_PORT=config.smtp.port,
        MAIL_FROM=config.smtp.from_email,
        MAIL_FROM_NAME=config.smtp.from_name,
        MAIL_STARTTLS=config.smtp.starttls,
        MAIL_SSL_TLS=config.smtp.ssl_tls,
        MAIL_DEBUG=config.logbook.debug,
        USE_CREDENTIALS=config.smtp.use_credentials,
        VALIDATE_CERTS=config.smtp.validate_certs,
        TIMEOUT=config.smtp.timeout,
        TEMPLATE_FOLDER=config.smtp.template_folder,
        SUPPRESS_SEND=config.smtp.suppress_send,
    )

def send_admin_notification(background_tasks: BackgroundTasks, subject: str, body: dict):

    if not config.logbook.admin_email:
        log.debug('Should send admin notification with subject "' + subject + '" but logbook.admin_email is not configured')
        return

    send_mail(
        background_tasks=background_tasks,
        template_name='admin_notification.html',
        email_to=config.logbook.admin_email,
        subject=subject,
        body=body
    )

def send_mail(background_tasks: BackgroundTasks, template_name:str, subject: str, email_to: str,body: dict):

    if not email_to:
        log.debug('Should send email with subject "' + subject + '" but email_to is not defined')
        return

    if not smtpconf:
        log.debug('Should send email with subject "' + subject + '" to "' + email_to + '" but smtp is not configured')
        return

    log.debug('Sending email with subject "' + subject + '" to "' + email_to + '"')

    message = MessageSchema(
        subject=subject,
        recipients=[email_to],
        template_body=body,
        subtype=MessageType.html
    )
    fm = FastMail(smtpconf)
    if(background_tasks != None):
        background_tasks.add_task(fm.send_message, message, template_name=template_name)
    else:
        fm.send_message(message=message, template_name=template_name)
