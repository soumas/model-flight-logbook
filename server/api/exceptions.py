from fastapi import HTTPException, status

invalid_api_key = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="INVALID_API_KEY")
primary_key_violation = HTTPException(status_code=status.HTTP_409_CONFLICT, detail="PRIMARY_KEY_VIOLATION")
item_not_found = HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="ITEM_NOT_FOUND")
active_session_available = HTTPException(status_code=status.HTTP_409_CONFLICT, detail="ACTIVE_SESSION_AVAILABLE")
unknown_pilot = HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="UNKNOWN_PILOT")