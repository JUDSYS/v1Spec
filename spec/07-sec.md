# Security and Usability Considerations

✏️

## Dynamic Content

All signing apps MUST warn the user when the document they are trying to sign seems to have dynamic content.

All signing apps MUST also not show the warning to the user if they have checked and failed to find signs of dynamic content on the file being signed.

If a signing app cannot verify the file for dynamic content and it is not on the white list, it MUST warn the user about the possibility of dynamic content.

For PDF, the verification MUST check for, and fail to find all of the following:

  1. Any signs of Javascript.

For HTML, the verification MUST check for, and fail to find all of the following:

  1. The `<script>` tag.
  2. Properties such as `onclick` and `oninput` on any tags.
  3. External URLs for the tags `<link>` and `<style>`. Note that links, `<a>` tag, are fine regardless of the URL they point to and the `<script>` tag will fail the verification independently of the URL.

For Office Open XML (MOX), Open Document Format for Office Applications (ODF) and older Microsoft Office files, the verification MUST check for, and fail to find all of the following:

  1. OLE content.
  2. (✏️ what else?)

All signing apps CAN assume that the following file formats have no dynamic content:

  1. Image files, including JPEG (`.jpg` and `.jpeg`), PNG (`.png`), GIF (`.gif`), BMP (`.bmp`) and TIFF (`.tiff` and `.tif`).
  2. Text files, including pure text (`.txt`) and rich text (`.rtf`).
  3. Markdown files (`.md`).
  4. TeX files (`.tex`).
  5. XML files (`.xml`).

All signing apps MUST check extension in a case insensitive manner.


## Accidental changes 

👉 Decide how to handle the case of a user who opened a word file, accidentally added a new line and saved it. The best option seems to be mandatory PAR2 support.

## Archive files

👉 Decide how to handle the case of a user trying to sign a `.zip` or `.rar` file. Should they be warned about the fact the signature will only apply to all those files together instead of separately? 


