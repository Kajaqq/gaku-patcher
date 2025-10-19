import time
import re
from typing import Union, Optional, Any
from urllib.error import HTTPError
from urllib.request import Request, urlopen

MAX_RETRIES = 3
RATE_LIMIT_DELAY = 5

class NotFoundError(Exception):
    pass

class ExtraHTTPError(Exception):
    pass

class Regex:
    SCRIPT = re.compile(r"AF_initDataCallback[\s\S]*?</script")
    KEY = re.compile(r"(ds:.*?)'")
    VALUE = re.compile(r"data:([\s\S]*?), sideChannel: {}}\);</")


def _urlopen(obj) -> str:
    try:
        resp = urlopen(obj)
    except HTTPError as e:
        if e.code == 404:
            raise NotFoundError("App not found(404).")
        raise ExtraHTTPError(f"App not found. Status code {e.code} returned.")
    return resp.read().decode("UTF-8")

def post(url: str, data: Union[str, bytes], headers: dict) -> str:
    last_exception = Exception("Max retries exceeded")
    
    for attempt in range(MAX_RETRIES):
        try:
            resp = _urlopen(Request(url, data=data, headers=headers))
            if "com.google.play.gateway.proto.PlayGatewayError" not in resp:
                return resp
            
            # Rate limit encountered
            last_exception = Exception(f"Rate limit exceeded after {MAX_RETRIES} retries")
            time.sleep(RATE_LIMIT_DELAY * (attempt + 1))
            
        except Exception as e:
            last_exception = e
    
    raise last_exception

def get(url: str) -> str:
    return _urlopen(url)

def nested_lookup(source: Any, indexes: list) -> Optional[Any]:
    try:
        result = source
        for index in indexes:
            result = result[index]
        return result
    except (TypeError, KeyError, IndexError):
        return None