from __future__ import annotations

from typing import Any

import requests


def _get_checkin_param() -> Any | None:
    """
    Fetches the checkin parameter from the APKCombo checkin endpoint.

    Returns:
        str: The checkin parameter or None if an error occurs.
    """
    try:
        response = requests.post('https://apkcombo.com/checkin', timeout=10)
        response.raise_for_status()
        return response.text.strip()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching checkin parameter: {e}")
        return None


class APKComboInfo:
    def __init__(self, apkcombo_url: str):
        self.apkcombo_url = apkcombo_url
        self.xapk_download_url, self.xapk_version = self._get_xapk_download_url()

    def _get_xapk_download_url(self) -> Any | None:
        """
        Extracts the XAPK download URL from the APKCombo page.

        Returns:
            str: The XAPK download URL or None if not found.
       """
       
        try:
            response = requests.get(self.apkcombo_url, timeout=10)
            response.raise_for_status()
            html_content = response.text

            # # Find the download URL location
            # xapk_url_start = html_content.find('<div class="download-content"') 
            # xapk_url_start = html_content.find('href=', xapk_url_start) + len('href="')
            # while xapk_url_start != -1:
            #     # Find the end of the url candidate
            #     xapk_url_end = html_content.find('"', xapk_url_start)
            #     temp_url = requests.utils.unquote(html_content[xapk_url_start:xapk_url_end])
            #     #If it contains the game ID, that's our download link
            #     if 'com.bandainamcoent.idolmaster_gakuen' in temp_url:
            #         xapk_download_url = temp_url
            #         break
            #     xapk_url_start = html_content.find('href=', xapk_url_end)
            # else:
            #     raise requests.exceptions.RequestException # No XAPK found

            # # Add checkin parameter to the download URL
            # checkin_param = _get_checkin_param()
            # if checkin_param:
            #     xapk_download_url += '&' + checkin_param


            # The URL can be hard-coded as it seems to always point to the latest release, and dynamically updating it would probably require a web-driver
            
            xapk_download_url = 'https://d.apkpure.com/b/XAPK/com.bandainamcoent.idolmaster_gakuen?version=latest'
            version_text = 'Version:'
            version_string_start = html_content.find(version_text) + len(version_text)+1
            version_string_end = html_content.find(' - com.bandainamcoent.idolmaster_gakuen')
            version_string = html_content[version_string_start:version_string_end]

            return xapk_download_url, version_string

        except requests.exceptions.RequestException as e:
            print(f"Error fetching XAPK info: {e}")
            return None

# Example usage:
if __name__ == "__main__":
    apkcombo_url = "https://apkcombo.app/%E5%AD%A6%E5%9C%92%E3%82%A2%E3%82%A4%E3%83%89%E3%83%AB%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%BC/com.bandainamcoent.idolmaster_gakuen/download/apk"
    apk_info = APKComboInfo(apkcombo_url)
    xapk_url = apk_info.xapk_download_url
    xapk_version = apk_info.xapk_version

    if xapk_url:
            print(xapk_version+xapk_url)
    else:
        print("Failed to retrieve XAPK download URL or XAPK not found.")
