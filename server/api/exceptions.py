from fastapi import HTTPException, status

#401
invalid_api_key = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="INVALID_API_KEY")
# 404
flightsession_not_found = HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="FLIGHTSESSION_NOT_FOUND")
unknown_pilot = HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="UNKNOWN_PILOT")
unknown_terminal = HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="UNKNOWN_TERMINAL")
inactive_pilot = HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="INACTIVE_PILOT")
unknown_session = HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="UNKNOWN_SESSION")
#409
active_flightsession_found = HTTPException(status_code=status.HTTP_409_CONFLICT, detail="ACTIVE_FLIGHTSESSION_FOUND")