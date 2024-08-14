import os
from fastapi import BackgroundTasks
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig, MessageType
from config.manager import config

conf = ConnectionConfig(
    MAIL_USERNAME=config.get('smtp', 'username'),
    MAIL_PASSWORD=config.get('smtp', 'password'),
    MAIL_SERVER=config.get('smtp', 'server'),
    MAIL_PORT=config.getint('smtp', 'port'),
    MAIL_FROM=config.get('smtp', 'from_email'),
    MAIL_FROM_NAME=config.get('smtp', 'from_name'),
    MAIL_STARTTLS=config.getboolean('smtp', 'starttls'),
    MAIL_SSL_TLS=config.getboolean('smtp', 'ssl_tls'),
    USE_CREDENTIALS=config.getboolean('smtp', 'use_credentials'),
    VALIDATE_CERTS=config.getboolean('smtp', 'validate_certs'),
    TIMEOUT=config.getint('smtp', 'timeout'),
    TEMPLATE_FOLDER=config.get('smtp', 'template_folder') # DirectoryPath
)

def send_mail(background_tasks: BackgroundTasks, subject: str, email_to: str, body: dict):
    message = MessageSchema(
        subject=subject,
        recipients=[email_to],
        template_body=body,
        subtype=MessageType.html
    )
    fm = FastMail(conf)
    background_tasks.add_task(fm.send_message, message, template_name='utm_started.html')