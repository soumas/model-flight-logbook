
def appendMessages(msgList:list, messagesStr:str | None):
    if messagesStr != None:
        for msg in messagesStr.split(';'):
            msgStripped : str = " ".join(msg.split())
            if msgStripped:
                msgList.append(msgStripped)
    