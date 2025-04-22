from __future__ import annotations

from typing import Any

import requests

import yaml

class APKInfo:
    def __init__(self, version_url: str):
        self.version_url = version_url
        self.xapk_download_url = self._get_xapk_download_url()
        self.xapk_version = self._get_xapk_version()

    def _get_xapk_download_url(self) -> Any | None:
            # The URL can be hard-coded as it seems to always point to the latest release, and dynamically updating it would probably require a web-driver
            
            download_url = 'https://d.apkpure.com/b/XAPK/com.bandainamcoent.idolmaster_gakuen?version=latest'
            
            return download_url
        

    def _get_xapk_version(self) -> str | None:
        """
        Retrieves the XAPK version string from a YAML file hosted at `self.version_url`.
        The YAML file is expected to contain version information for multiple platforms.
        This method specifically extracts the version information for the Android platform.
        Returns:
            str | None: The XAPK version string, formatted as 'major.minor.patch', or None if an error occurred
                          during the process (e.g., network issues, invalid YAML format, or no Android version found).
        Raises:
            requests.exceptions.RequestException: If there's an issue with the HTTP request (e.g., timeout, connection error).
            IndexError: If no Android version is found in the YAML file.
        """
        try:
            response = requests.get(self.version_url, timeout=10)
            response.raise_for_status()
            version_yaml = response.text
            version_object = yaml.load(version_yaml, Loader=yaml.Loader)
            version_object = next((sub for sub in version_object if sub['platformType'] == "PlatformType_Android"), None)
            if version_object is None:
                raise IndexError("No Android version found in YAML")
            version_list = list(version_object.values())[1:]
            version_string = '.'.join(str(version) for version in version_list)
            return version_string
        
        except requests.exceptions.RequestException as e:
            print(f"Error fetching XAPK version: {e}")
            return None
            
# Example usage:
if __name__ == "__main__":
    version_url = "https://raw.githubusercontent.com/vertesan/gakumasu-diff/refs/heads/main/ForceAppVersion.yaml"
    apk_info = APKInfo(version_url)
    xapk_url = apk_info.xapk_download_url
    xapk_version = apk_info.xapk_version

    if xapk_url:
            print(xapk_version+xapk_url)
    else:
        print("Failed to retrieve XAPK download URL or XAPK not found.")
