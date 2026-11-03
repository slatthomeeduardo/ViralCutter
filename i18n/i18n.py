import json
import locale
import os

LOCALE_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "locale")

def load_language_list(language):
    lang_file = os.path.join(LOCALE_DIR, f"{language}.json")
    if not os.path.exists(lang_file):
        lang_file = os.path.join(LOCALE_DIR, "en_US.json")
    with open(lang_file, "r", encoding="utf-8") as f:
        language_list = json.load(f)
    return language_list


class I18nAuto:
    def __init__(self, language=None):
        if language in ["Auto", None]:
            try:
                language = locale.getdefaultlocale()[0]
            except Exception:
                language = "en_US"
        if not language or not os.path.exists(os.path.join(LOCALE_DIR, f"{language}.json")):
            language = "en_US"
        self.language = language
        self.language_map = load_language_list(language)

    def __call__(self, key):
        return self.language_map.get(key, key)

    def __repr__(self):
        return "Use Language: " + self.language
