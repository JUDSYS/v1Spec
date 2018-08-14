# JUDSYS-1

*Current Status*: Just began.

JUDSYS-1 (**J**SON **U**nified **D**igital **S**ignature S**y**stem **S**tandard) is a standard meant to replace CMS/CAdES, XML-DSIG/XAdES, PAdES (PDF) and other digital signature systems.

This is mainly intended for Brazil, but it should be able to work for other countries with minimal or no changes.

Main points:

  * Full Unicode support for strings with an ASCII fallback. Examples:
    ```
    {"name": "República Feberativa do Brasil 🇧🇷", "name_ascii: "Republica Federativa do Brasil"}
    {"name": "中华人民共和国 🇨🇳", "name_ascii: "Zhong1hua2 Ren2min2 Gong4he2guo2"}
    ```
  * Full certification chain is always included (except for the root CAs).
  * Simple and consistent JSON syntax with base64 to avoid canonicalization problems.
  * Minimal number of allowed algorithms in order to make implementations and interoperability easier.
  * Single document for all the rules. (timestamps, CA rules, hardware interaction, user interaction and naming conventions)
  * Ease for users: Minimal options and variations to make digital signatures easy (or at least easier) to use.
    * Standard naming conventions.
    * Detached only signatures: this is for interoperability and to avoid unnecessary backups. (also it reduces the memory needed to parse the files)
    * Only two signature types: regular and time-verified.
    
