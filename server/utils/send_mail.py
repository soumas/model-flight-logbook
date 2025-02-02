#import os
import asyncio
from fastapi import BackgroundTasks
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig, MessageType
from config.configmanager import config
from utils.logger import log

import traceback


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

def send_mail(to: str, subject: str, body: dict | str, template_name:str = 'notification.html', bcc: str | None = None, background_tasks: BackgroundTasks | None = None):

    try:
        if not to:
            log.debug('Should send email with subject "' + subject + '" but email_to is not defined')
            return

        if not smtpconf:
            log.debug('Should send email with subject "' + subject + '" to "' + to + '" but smtp is not configured')
            return

        msgbody = None
        if isinstance(body, str):
            msgbody = {'message':body}
        else:
            msgbody = body

        log.debug('Sending email with subject "' + subject + '" to "' + to + '"')

        message = MessageSchema(
            subject=subject,
            recipients=[to],
            bcc=[bcc] if bcc is not None else [],
            template_body=msgbody,
            subtype=MessageType.html
        )
        fm = FastMail(smtpconf)
        if(background_tasks != None):
            background_tasks.add_task(fm.send_message, message, template_name=template_name)
        else:
            asyncio.run(send_message_async(fm, message, template_name))
    except:
        # don't throw exception when notification fails
        log.error(traceback.format_exc())

async def send_message_async(fm, message, template_name):
    await fm.send_message(message, template_name)