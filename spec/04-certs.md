# Certificates

✏️

## Subject Attributes

Unless otherwise specified, all attributes are arrays.

The CA MUST verify the attributes it will use on certificates it issues. If any verification is not done or fails, the corresponding attributes MUST NOT be included in the issued certificate. Examples:

1. If the CA fails to verify that a phone number really belongs to the subject, it MUST never be included.
2. If the subject of the certificate to be issued forgets to bring their US/SSN, this attribute MUST not be included in the certificate.

If a CA MAY refuse to issue a certificate if essential properties could not verified. Examples: INT/name, US/SSN, BR/RG, BR/CPF.

### INT/name

Each name is a one line Unicode string.

All name entries each MUST be at most 5 KiB long.

All apps MUST suport such long names. They MAY, however, show only the begining of the name by default and have a simple way to show the full name. Example: a tooltip or a button close to the name.

There MUST be at least one name in the `INT/name` attribute.

Any prefixes, sufixes, infixes, honorifics and similar things attached to the name MUST be verified. Example: a person may never use the prefix "Dr." if they have no valid doctorates degree.

Generic prefixes like "Mr." or "Ms." and job titles MUST NOT be included in any of the names.

For legal persons, it is recommended to follow the convention: `(<Acroymum>) <Full Legal Name> <Any special endings>` Examples:

1. (USP) Universidade São Paulo
2. Monsters Inc.
3. Empresa Qualquer Serviços e Comércio LTDA

For natural persons, it is recommended to follow the convention: `(<Nick Name>) <First Name> <Full Middle Name> <Last Name>` Examples:

1. Dennis MacAlister Ritchie
2. (FHC) Fernando Henrique Cardoso
3. (Dom Pedro II) Pedro de Alcântara João Carlos Leopoldo Salvador Bibiano Francisco Xavier de Paula Leocádio Miguel Gabriel Rafael Gonzaga

### INT/parents

### INT/email

An array of the subject's email addresses.

The fist entry is considered the main one.

The subject MAY have no email address.

It is RECOMENDED to have at least one ASCII email address.

Examples:
```js
// Okay:
[]
["someone@example.com"]
["josé@construções-ltda.br", "jose@construcoes-ltda.br"]
["josé@construções-ltda.br", "jose@xn--construes-ltda-mjb8t.br"]
["josé@construções-ltda.br", "jose@construcoes-ltda.br", "josé@xn--construes-ltda-mjb8t.br"]
["josé@construções-ltda.br"]
["jose@construcoes-ltda.br", "josé@construções-ltda.br"]
```

### INT/phones

For SPAM/robo-calling prevention the subject MUST have the right to refuse the inclusion of the `INT/phone` attribute.

The phone numbers MUST be encoded as a string array. Each element of that array represents one phone number and MUST include the country and area codes. 

The country code part MUST begin with a `+` (plus sign) and have a space to separate it from the rest of the number. This is mainly to aid humans, by separating the international part from the local one.

The rest of the number SHOULD follow the traditions and conventions of the country in question and MAY include punctuation.

Examples:

```js
// Okay:
[]
["+55 (11) 0 0000-0000", "+55 0800 000"]
// Wrong:
["+55(11) 0 0000-0000", "+550800000", "55 0800 000"]
```

Note: This attribute is intended to be used by some legal persons and by pretty much no natural persons.

### INT/addresses

For security reasons the subject MUST have the right to refuse the inclusion of `INT/address` attribute.

### INT/picture

For privacy reasons the subject SHOULD have the right to refuse the inclusion of `INT/picture` attribute. The CA, however, CAN require this attribute but its is encouraged not to require it.

The picture MUST always be static: no animated GIFs or similar.

For natural persons the image MUST be picture of the subject. The specific are left to the CA, but it SHOULD follow the traditions and conventions of the CA's country.

One suggestion for CAs is to follow the ICAO guidlines on photos for passports.

For legal persons the image MUST be a logo or other symbol that represents the subject. It MUST NOT be a picture of the owners or of the place where the subject is. Again, specific are left to the CA.

Support for this property in apps is OPTIONAL but RECOMENDED to those that have a GUI.

Those that decide to implement this property MUST be able do decode JPEG and PNG.

The picture MUST be data URL encoded using base64 and MUST NOT exceed 1 MiB. The size restriction applies to the image itself, not to the string that encodes it.

Example: (Tux, the Linux mascot)

```js
"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD//gAiUmVzaXplZCB3aXRoIGV6Z2lmLmNvbSBHSUYgbWFrZXL/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAAmACADASIAAhEBAxEB/8QAGQAAAwEBAQAAAAAAAAAAAAAABgcIAAUE/8QALRAAAQMDAgQFAwUAAAAAAAAAAQIDBAUGEQAHEiExQQgTFCJxFVGBMlJhcrH/xAAXAQEBAQEAAAAAAAAAAAAAAAADAgQF/8QAJhEAAgICAQMCBwAAAAAAAAAAAQIDBAARMQUhQRNxEhQigaHR8P/aAAwDAQACEQMRAD8AsvUleN/cDcWk1yNb1lyajTqbGhtyajLhZStS3XFIbQVjmB7eg6lXPtqtdIDcOnRbm3bqkyNR/rkWkw40GTggoRJKnFlscsFQSWyRk4ynvrNbnavC0ioXI8Dk4kSB3Ck698C/CbuduEncRG2u4Sp77kmnqlRXZ6wt9C0ZJHEOZSUhXI5IKfkarPUYXbHVs34gLGvKsQU06hSWnI3C0StDJdW55xUScgguhZ65GemNWWy4260h1paVtrSFJUk5CgehB+2kgkMsauVKk+DyPfWS6/CxG94Gb4Xi1Ym19auFTwbktx1NQh3XJWOFsAdzxHPwDrw7AWc7ZO2NLpk6U/JqcsmdUHXFlSlyHfevJ6nGQM98Z0P7xRYF8Nrt2tQEKhwZfmtKS4oLDqUlKVgggAjiJAORrsbN3nWLglVS3bho70eo0QoHr22iIs5pYPAtB6JXge5HY9P45dPrtO7akqxH6k58cHR17HnNM1KWGNZGHY5w/F5Y0C7dnKxMkrd9RRmVVGN7iQC2CVDGeWUcQ+caFvANe0y4ttqhbdRkuSXrfkpbjuOElXpnEkoSf6lKwPsMDtpj7+TfUWbLtGLLYaqFdhyGG0KUCrgKCFK4evCOIZP40u/B9ZI22g1KJWJTDlSqzjZU42CEAI4glHPv7lHOBn8aSbrVOCyKsr6c60D53v8AWSlSV4/VUbGNavWIuXKel02ruR3nlqcLb7QdQVHmeYwQPydB7G1941SpuTX7/n2021llLVCXzewf1OFxOOXYBJIz11tbRJ0ajBdWzHGA533G/P4xDbmeEozbHbOKrYOZQLoXetPvWq1+rqbLL/157jy2f2rQnII5YGMdemmzaFqtU2O1KqCm5dQ5KKwD5bZ+yAf9PP41tbSN02rLe+ZdAXAGif7X35yRYlWD0w2hvP/Z"
```

### INT/passport

An [ICAO Doc 9303] passport.

Each passport is encoded as a dictionary with the following keys:

1. `type` (mandatory): Indicates the type of document, for passports this is a `P`.
2. `number` (mandatory): A string, which MAY contain letters, the identifies this passport.
3. `country` (mandatory): The country that issued the passort.
4. `surname` (optional): The subject's last name.
5. `given_name` (optional): The subject's first name.
6. `nationality` (optional): The subject's nationality.
7. `date_of_birth` (mandatory): The subject's date of birth.
8. `place_of_birth` (optional): The subject's place of birth.
9. `personal_number` (optional): An id number identifying the subject.
10. `sex` (optional): The sex or gender of the subject. Note that `X` and other characters may be used instead of the traditional `F` and `M`. 
11. `date_of_issue` (mandatory): The date in which the passport was issued.
12. `date_of_expiry` (optional): The date in which the passport will expire.
13. `MRZ` (optional): the contents on the MRZ (machine redable zone).

The `given_name` and `surname` are optional beacuse some people may have no first or last name. However, at least one of them MUST be included.

Except of dates, it is RECOMMENDED that all fields match the way they are presented on the VIZ (Visual Inpection Zone), rather than the MRZ.

```js
{
    "type": "P",
    "country": "UTO", // This may not match ISO 3166-1, read ICAO Doc 9303 (pages 22 to 29) for deatils.
    "number": "L898902C3",
    "surname": "ERIKSSON",
    "given_name": "ANNA MARIA",
    "nationality": "UTOPIAN",
    "date_of_birth": "1974-08-12",
    "place_of_birth": "ZENITH",
    "personal_number": "Z E 184226 B",
    "sex": "F", // Do NOT assume it is "F" or "M", other chacraters, such as "X" may de used.
    "date_of_issue": "2007-04-16",
    "date_of_expiry": "2012-04-15",
    "MRZ": "P<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<\nL898902C36UTO7408122F1204159ZE184226B<<<<<10"
}
```

