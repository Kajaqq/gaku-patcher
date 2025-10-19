import json
from typing import Optional
from utils import nested_lookup, Regex, get

def get_version(app_id: str, lang: str = 'en') -> Optional[str]:
    url = f"https://play.google.com/store/apps/details?id={app_id}&hl={lang}"
    dom = get(url)
    matches = Regex.SCRIPT.findall(dom)

    dataset = {}
    for match in matches:
        keys = Regex.KEY.findall(match)
        values = Regex.VALUE.findall(match)
        if keys and values:
            dataset[keys[0]] = json.loads(values[0])

    return nested_lookup(dataset.get("ds:5"), [1, 2, 140, 0, 0, 0])


def main(app):
    app_ver = get_version(app)
    print(app_ver)


if __name__ == "__main__":
    app_id = 'com.bandainamcoent.idolmaster_gakuen'
    main(app_id)