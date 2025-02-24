from sqlalchemy import exc
from requests import Session
from fastapi import HTTPException, status

def commit_with_httpexceptionhandling(db: Session):
    try:
        db.commit()
    except exc.IntegrityError as ie:
        if ie.args and len(ie.args) > 0 and "UNIQUE" in ie.args[0].upper():
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail='Ein Datensatz mit dieser ID existiert bereits ('+ie.params[0]+')')
        else:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail='sql allgem')
    except Exception as err:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail='Unbekannter Fehler beim Speichern der Daten')