import os
from fastapi import BackgroundTasks
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig, MessageType
from config.configmanager import config

conf = ConnectionConfig(
    MAIL_USERNAME=config.smtp.username,
    MAIL_PASSWORD=config.smtp.password,
    MAIL_SERVER=config.smtp.server,
    MAIL_PORT=config.smtp.port,
    MAIL_FROM=config.smtp.from_email,
    MAIL_FROM_NAME=config.smtp.from_name,
    MAIL_STARTTLS=config.smtp.starttls,
    MAIL_SSL_TLS=config.smtp.ssl_tls,
    MAIL_DEBUG=config.smtp.debug,
    USE_CREDENTIALS=config.smtp.use_credentials,
    VALIDATE_CERTS=config.smtp.validate_certs,
    TIMEOUT=config.smtp.timeout,
    TEMPLATE_FOLDER=config.smtp.template_folder,
    SUPPRESS_SEND=config.smtp.suppress_send,

)

def send_mail(background_tasks: BackgroundTasks, template_name:str, subject: str, email_to: str, body: dict):
    message = MessageSchema(
        subject=subject,
        recipients=[email_to],
        template_body=body,
        subtype=MessageType.html
    )
    fm = FastMail(conf)
    background_tasks.add_task(fm.send_message, message, template_name=template_name)