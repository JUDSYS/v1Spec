%%%
title = "JSON Unified Digital Signatures System Standard 1"
abbrev = "JUDSYS1"
ipr= "trust200902"
area = "Internet"
workgroup = "No Formal Workgroup"
keyword = ["cryptography", "digital signature", "protocol"]


[seriesInfo]
status = "experimental"
name = "Internet-Draft"
value = "draft-judsys1-00"
stream = "independent"

date = 2018-09-11T00:00:00Z

[[author]]
initials="G."
surname="Queiroz"
fullname="Gabriel Villela Noriega de Queiroz"
  [author.address]
  email = "gabrieljvnq@gmail.com"
  [author.address.postal]
  country = "Brazil"
%%%

.# Abstract

A simple digital signature standard designed to be used by regular people and to be of mandatory acceptance and to replace PAdES, XAdES and CAdES.

{mainmatter}

# Introduction

Currently, ITI, the government body responsible of ICP-Brasil, Brazil's PKI (Public Key Infrastructure), endorses three different standards: CAdES, XAdES and PAdES.

Since they are all based on X.509 which is used in SSL, there should be an abundance of good software libraries and end user applications to support at least one of these standard.

This is not the case. While there have been some efforts to write open source libraries and end user applications for ICP-Brasil, they are hard to find and most seem unfinished and abandoned.

ITI provides a digital signature verification web tool, but it is only for CAdES and doesn't seem to work well.

PAdES is a monster of its own kind. In an attempt to replicate the paper experience in the digital world, a PDF file can be signed, edited and resigned by another person in a way that they signed over different version of the same document. This is both hard to implement and hard to explain to end users.

To make matters worse, PDF readers almost never come with the necessary CAs to verify ICP-Brasil digital signatures.

Perhaps as result of this mess of different standards, the ITI admits that, no one is obliged to accept digital signatures in Brazil (see [@ITI-FAQ-21]).

This situation is unacceptable. We need a digital signature standard that:

1. Is easy for programmers to implement. Including reference libraries in multiple languages.
2. Is easy for ordinary people to use on a day to day basis.
3. Has strict rules to avoid interoperability problems.
4. Has mandatory acceptance by law.

This document aims to provide a digital signature standard that address points one through three. Hopefully, this standard may fulfil the fourth point in the near future.

## Right of Implementation

Any person, group or organization can freely implement this standard so long as the implementation is complete.  

## Terminology

The keywords **MUST**, **MUST NOT**, **REQUIRED**, **SHALL**, **SHALL NOT**, **SHOULD**,
**SHOULD NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL**, when they appear in this
document, are to be interpreted as described in [@!RFC2119].

All apps **MUST** use the standard translations present in this document when they present in the Language specific rules section.

**User**: A human being using a JUDSYS app. Unless otherwise specified, users **MUST** always be considered as non-tech-savvy people.

**Signing app**: A computer program that digitally signs documents according to this standard.

**Verifier app**: A computer program that verifies a digital signature according to this standard.

(**App**) **JUDSYS app** or **implementation**: A computer program that is either a singing app or a verifier app or both.

**Subject attributes**: Certain values that qualify the subject. Ex: email, full name, government issued identification numbers, et cetera.

**Natural person**: A human begin.

**Legal person**: A group of people who the Law considers to be its own person. 

**Software person**: A piece of software that acts in the name of a natural or legal person.

**Digital signature**:

(**PKI**) **Public Key Infrastructure**: 

(**KP**) **Key Pair**:

**Certificate**: A short signed message that states a key pair is in the control of a specific subject.

(**CA**) **Certificate Authority**: A certificate that is allowed to sign other certificates. This is, a CA is an entity (usually a company or government body) that ensures that the subject on a certificate is really the person it names. 

(**PA**) **Proof of attribute**: A short signed message in which the issuer certifies that a certain attribute is true. Examples: job titles and permissions delegated by the issuer to the subject.

(**TA**) **Time-stamping Authority**

This is very similar to the concept of attribute certificates. The names was changed to avoid using the "certificate" in two different contexts that may confuse users.

**ICAO**: International Civil Aviation Organization.

**JSON**: JavaScript Object Notation.

# Encoding

## Files

All JUDSYS-1 files are JSON encoded with UTF-8.

To avoid canonicalization problems, all signed messages are encoded in base64.

Example:

```js
{"b": 1, "a":2}
// becomes
{
    "raw": "eyJiIjogMSwgImEiOjJ9Cg==",
    // This is to aid humans debugging, not for machines to use 
    "what": "JUDSYS-1 base64"
}
```

### File extensions

All JUDSYS-1 extensions begin with `.j1` (dot, jay, one). 

For JUDSYS-1 files, all apps **MUST** use only the file extensions show below:

| Extension | Usage                                  |
|-----------|----------------------------------------|
| `.j1c`    | Certificates (no private keys)         |
| `.j1a`    | A single proof of attribute            |
| `.j1k`    | Certificates with the private keys     |
| `.j1s`    | Detached digital signature             |
| `.j1e`    | Encrypted file                         |
| `.j1r`    | Revocation information                 |
| `.j1d`    | Reserved for a future [WYSIWYS] format |

[WYSIWYS]: https://en.wikipedia.org/wiki/WYSIWYS

## Strings

All apps **MUST** have proper Unicode support and fonts to display any characters that may be necessary for the country of intended use. This is, an app for France **MUST** have fonts with accented characters, but **MAY** have no CJK nor Cyrillic support. An app for Russia **MUST** have Cyrillic and Latin support, but **MAY** have no CJK or Mongolian support.

It is **RECOMMENDED** to store string in NFC (Normal Form Composition).

It is **RECOMMENDED** that all apps support as much Unicode characters and scripts as possible. It is also RECOMMENDED that all apps include the necessary fonts.

Emoji usage is discouraged.

## Dates

All dates **MUST** be encoded as strings according to the [@!RFC3339].

If the time is not available, it **MUST** be assumed to be midnight.

Times **MUST NOT** include fractions of a second.

## Country-like codes

In this spec, country-like means any sovereign state, international organization or similar. For example, the United Nations, the European Union, the UK and the International Court of Justice are country-like but England and Wales are not.

All countries-like **MUST** be represented by the upper case three letter codes defined on ISO 3166-1 alpha-3. If a country-like does not have such code, it **MUST** be full English name with spaces and proper capitalization. Ex: `Principality of Sealand` not `principality of sealand` nor `PrincipalityOf_Sealand`.

International organizations **MUST** use their upper case English acronym and their full English name separated by a hyphen with spaces on both sides. Ex: `ICAO - International Civil Aviation Organization` and `ICJ - International Court of Justice`.

Special cases are:

  1. `UN` for the United Nations (already on the ISO 3166-1 alpha-2).
  1. `EU` for the European Union (already on the ISO 3166-1 alpha-2).
  1. `INT` for international things such as passports, names and date of birth.
  1. `MERCOSU` for the Southern Common Market, Mercosur in Spanish and Mercosul in Portuguese.
  1. `UNASU` for the Union of South American Nations, UNSAUR in Spanish and UNASUL in Portuguese.
  1. `NAFTA` for the North American Free Trade Agreement.
  1. `HOAX` for URSAL - União das Repúblicas Socialistas da America Latina. (just a joke, non-normative)

## Certificate chains

All JUDSYS-1 certification chains are simple trees with root CAs at the top.  Cross-signing or other complicated methods **MUST NOT** be used. 

All JUDSYS-1 files **MUST** include exactly all the necessary certificates, attribute certificates and revocation files for verifying the file in question.

An exception is made to the root CAs which **MUST NOT** be included in any JUDSYS-1 file, as they **MUST** be a part of the apps themselves, preferably in the implementation source code.

# Certificates

A certificate is a signed message in which the issuer certifies that the subject has those keys.

A certificate is an object with the following keys:

1. `subject`: An entity describing the subject.
2. `issuer`: The key id of the issue-certs key of the CA.
3. `notBefore`: The time in which the certificate starts being valid.
4. `notAfter`: The time in which the certificate expires.
5. `keys`: An array holding multiple public keys.
6. `public-faith`: An array of of strings indicating which types of signature the subject has "public-faith". This is, what hey say is assumed to be e true.

## Keys

All keys are encoded as a dictionaries, which **MUST** have the following keys:

1. `algorithm`
2. `id`: A hash of the key that uniquely identifies it.
3. `usage`: An enum that indicates what the key may be used for. Possible values:
   1. `signing`: The key is used only to sign digital documents, issue and revoke attribute certificates.
   2. `identification`: They key is used only to identify the subject. Ex: login.
   3. `encryption`: The key is used only for any person to encrypt messages to the subject.
   4. `certification`: The key is used only to issue digital certificates.
   5. `revocation`: They key is used only to issue certificate revocations.

Each key **MUST NOT** be used in any algorithms other than the one prescribed on the key `usage`.

Key material **MUST NOT** be reused.

## Subject Attributes

Attributes in the singular are a single value and attributes in the plural are arrays. 

The CA **MUST** verify the attributes it will use on certificates it issues. If any verification is not done or fails, the corresponding attributes **MUST NOT** be included in the issued certificate. Examples:

1. If the CA fails to verify that a phone number really belongs to the subject, it **MUST** never be included.
2. If the subject of the certificate to be issued forgets to bring their USA/SSN, this attribute **MUST NOT** be included in the certificate.

A CA MAY refuse to issue a certificate if essential properties could not verified. Examples: INT/name, USA/SSN, BRA/RG, BRA/CPF.

### id

A string pointing to an attribute which no other entity shares that value. Examples: `BRA/CPF`, `USA/SSN`, `INT/passports:number`.

This is, two entities are the same when their respective ids (attribute name and value) match. The reverse is not guaranteed.

The syntax is `<key>` or `<key>:<sub-key>`. If there is an array, the first value is always used as if it were the only one.

### INT/type

An enum describing the type of the subject. Possible values are: `natural person`, `legal person`, and `other` (ex: software).

### INT/names

Each name is a one line Unicode string.

Each name entry **SHOULD** be at most 5 KiB long.

All apps **MUST** support such long names. They **MAY**, however, show only the beginning of the name by default and have a simple way to show the full name. Example: a tooltip or a button close to the name.

There **MUST** be at least one name in the `INT/names` attribute.

Any prefixes, suffixes, infixes, honorifics and similar things attached to the name **MUST** be verified. Example: a person may never use the prefix "Dr." if they have no valid doctorates degree.

Generic prefixes like "Mr." or "Ms." and job titles **MUST NOT** be included in any of the names.

For legal persons, it is **RECOMMENDED** to follow the convention: `(<Acronym>) <Full Legal Name> <Any special endings>` Examples:

1. (USP) Universidade São Paulo
2. Monsters Inc.
3. Empresa Qualquer Serviços e Comércio LTDA

For natural persons, it is **RECOMMENDED** to follow the convention: `(<Nick Name>) <First Name> <Full Middle Name> <Last Name>` Examples:

1. Dennis MacAlister Ritchie
2. (FHC) Fernando Henrique Cardoso
3. (Dom Pedro II) Pedro de Alcântara João Carlos Leopoldo Salvador Bibiano Francisco Xavier de Paula Leocádio Miguel Gabriel Rafael Gonzaga

### INT/parents

An array of entities. The order **MUST NOT** be assigned any meaning. The array **MAY** have any number of elements.

The `INT/parents` attribute **MAY** lead to a recursive behaviour. This attribute **SHOULD NOT** exceed the grandparents generations.

Example:
```js
[
  {"id": "BRA/CPF", "INT/names": ["João da Silva"], "BRA/CPF": "123.456.789-00"},
  {"id": "BRA/CPF", "INT/names": ["Maria da Silva"], "BRA/CPF": "987.654.321-00"},
  {"id": "BRA/CPF", "INT/names": ["Joaquim Freitas"], "BRA/CPF": "987.654.321-00"}
]
```

### INT/guardians

Pretty much the same as the `INT/parents` attribute.

It it is present, the entities `INT/parents` **MUST NOT** be considered as legal guardians.

It is absent, the entities `INT/parents` **MAY** be assumed to be legal guardians.

Example:
```js
[
  {"id": "BRA/CPF", "INT/names": ["João da Silva"], "BRA/CPF": "123.456.789-00"},
  {"id": "BRA/CPF", "INT/names": ["Maria da Silva"], "BRA/CPF": "987.654.321-00"},
  {"id": "BRA/CPF", "INT/names": ["Joaquim Freitas"], "BRA/CPF": "987.654.321-00"}
]
```

### INT/emails

An array of the subject's email addresses.

The fist entry is considered the main one.

The subject **MAY** have no email address.

It is **RECOMMENDED** to have at least one ASCII-only email address.

Examples:
```js
// Okay:
[]
["someone@example.com"]
["josé@construções-ltda.br", "jose@construcoes-ltda.br"]
["josé@construções-ltda.br", "jose@xn--construes-ltda-mjb8t.br"]
["josé@construções-ltda.br", "jose@construcoes-ltda.br",
 "josé@xn--construes-ltda-mjb8t.br"]
["josé@construções-ltda.br"]
["jose@construcoes-ltda.br", "josé@construções-ltda.br"]
```

### INT/phones

For SPAM/robo-calling prevention the subject **MUST** have the right to refuse the inclusion of the `INT/phone` attribute.

The phone numbers **MUST** be encoded as a string array. Each element of that array represents one phone number and **MUST** include the country and area codes. 

The country code part **MUST** begin with a `+` (plus sign) and have a space to separate it from the rest of the number. This is mainly to aid humans, by separating the international part from the local one.

The rest of the number **SHOULD** follow the traditions and conventions of the country in question and MAY include punctuation.

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

For security reasons the subject **MUST** have the right to refuse the inclusion of `INT/address` attribute.

### INT/pictures

For privacy reasons the subject SHOULD have the right to refuse the inclusion of `INT/pictures` attribute. The CA, however, CAN require this attribute but its is encouraged not to require it.

The picture **MUST** always be static: no animated GIFs or similar.

For natural persons the image **MUST** be picture of the subject. The specific are left to the CA, but it SHOULD follow the traditions and conventions of the CA's country.

One suggestion for CAs is to follow the ICAO guidelines on photos for passports (see [@ICAO-9303]).

For legal persons the image **MUST** be a logo or other symbol that represents the subject. It **MUST NOT** be a picture of the owners or of the place where the subject is. Again, specific are left to the CA.

Support for this property in apps is **OPTIONAL** but **RECOMMENDED** to those that have a GUI.

Those that decide to implement this property **MUST** be able do decode both JPEG and PNG.

The picture **MUST** be data URL encoded using base64 and **MUST NOT** exceed 1 MiB. The size restriction applies to the image itself, not to the string that encodes it.

The picture **MUST NOT** be rotated using metadata (see [@JPEG-HOFF]) regardless of the file type (JPGE or PNG or other).

Example: (Tux, the Linux mascot)

```
["data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD//gAiUmVzaXplZCB3aXRoIGV6Z2lmLmNvbSBHSUYgbWFrZXL/2wBDAAUDBAQEAwUEBAQFBQUGBwwIBwcHBw8LCwkMEQ8SEhEPERETFhwXExQaFRERGCEYGh0dHx8fExciJCIeJBweHx7/2wBDAQUFBQcGBw4ICA4eFBEUHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh7/wAARCAAmACADASIAAhEBAxEB/8QAGQAAAwEBAQAAAAAAAAAAAAAABgcIAAUE/8QALRAAAQMDAgQFAwUAAAAAAAAAAQIDBAUGEQAHEiExQQgTFCJxFVGBMlJhcrH/xAAXAQEBAQEAAAAAAAAAAAAAAAADAgQF/8QAJhEAAgICAQMCBwAAAAAAAAAAAQIDBAARMQUhQRNxEhQigaHR8P/aAAwDAQACEQMRAD8AsvUleN/cDcWk1yNb1lyajTqbGhtyajLhZStS3XFIbQVjmB7eg6lXPtqtdIDcOnRbm3bqkyNR/rkWkw40GTggoRJKnFlscsFQSWyRk4ynvrNbnavC0ioXI8Dk4kSB3Ck698C/CbuduEncRG2u4Sp77kmnqlRXZ6wt9C0ZJHEOZSUhXI5IKfkarPUYXbHVs34gLGvKsQU06hSWnI3C0StDJdW55xUScgguhZ65GemNWWy4260h1paVtrSFJUk5CgehB+2kgkMsauVKk+DyPfWS6/CxG94Gb4Xi1Ym19auFTwbktx1NQh3XJWOFsAdzxHPwDrw7AWc7ZO2NLpk6U/JqcsmdUHXFlSlyHfevJ6nGQM98Z0P7xRYF8Nrt2tQEKhwZfmtKS4oLDqUlKVgggAjiJAORrsbN3nWLglVS3bho70eo0QoHr22iIs5pYPAtB6JXge5HY9P45dPrtO7akqxH6k58cHR17HnNM1KWGNZGHY5w/F5Y0C7dnKxMkrd9RRmVVGN7iQC2CVDGeWUcQ+caFvANe0y4ttqhbdRkuSXrfkpbjuOElXpnEkoSf6lKwPsMDtpj7+TfUWbLtGLLYaqFdhyGG0KUCrgKCFK4evCOIZP40u/B9ZI22g1KJWJTDlSqzjZU42CEAI4glHPv7lHOBn8aSbrVOCyKsr6c60D53v8AWSlSV4/VUbGNavWIuXKel02ruR3nlqcLb7QdQVHmeYwQPydB7G1941SpuTX7/n2021llLVCXzewf1OFxOOXYBJIz11tbRJ0ajBdWzHGA533G/P4xDbmeEozbHbOKrYOZQLoXetPvWq1+rqbLL/157jy2f2rQnII5YGMdemmzaFqtU2O1KqCm5dQ5KKwD5bZ+yAf9PP41tbSN02rLe+ZdAXAGif7X35yRYlWD0w2hvP/Z"]
```

### INT/passports

Each passport is encoded as a dictionary with the following keys:

1. `type`: Indicates the type of document, for passports this is a `P`.
2. `number`: A string, which MAY contain letters, the identifies this passport.
3. `country`: The country that issued the passport.
4. `surname`: The subject's last name.
5. `given_name`: The subject's first name.
6. `nationality`: The subject's nationality.
7. `date_of_birth`: The subject's date of birth.
8. `place_of_birth`: The subject's place of birth.
9. `personal_number`: An id number identifying the subject.
10. `sex`: The sex or gender of the subject. Note that `X` and other characters may be used instead of the traditional `F` and `M`. 
11. `date_of_issue`: The date in which the passport was issued.
12. `date_of_expiry`: The date in which the passport will expire.
13. `MRZ`: the contents on the MRZ (machine readable zone).

Only `type`, `country` and `number` **MUST** be present.

The `given_name` and `surname` are **OPTIONAL** because some people may have no first or last name. However, at least one of them **MUST** be included.

Except of dates, it is **RECOMMENDED** that all fields match the way they are presented on the VIZ (Visual Inspection Zone), rather than the MRZ.

```js
{
    "type": "P",
    "country": "UTO", // This **MAY NOT** match ISO 3166-1, read ICAO Doc 9303 (pages 22 to 29) for details.
    "number": "L898902C3",
    "surname": "ERIKSSON",
    "given_name": "ANNA MARIA",
    "nationality": "UTOPIAN",
    "date_of_birth": "1974-08-12",
    "place_of_birth": "ZENITH",
    "personal_number": "Z E 184226 B",
    "sex": "F", /* Do NOT assume it is "F" or "M", other characters,
                   such as "X" may de used. */
    "date_of_issue": "2007-04-16",
    "date_of_expiry": "2012-04-15",
    "MRZ": "P<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<\nL898902C36UTO7408122F1204159ZE184226B<<<<<10"
}
```

# Certification Chain

👉 Open Question: Should software receive certificates? Ex: Should a bank have a specific certificate only for its web server that is used not for SSL but for singing that it approved clients requests (loans for instance) and singing bank statements?  

## Public Key Infrastructure

## Nameless Certificates

👉 Open Question: It is feature a good idea?

Nameless certificates are self signed certificates meant for the end user. They are intended to serve as a way for people to start using and testing JUDSYS-1 without the need to pay the CAs.

All nameless certificates **MUST** have, on both `subject` and `issuer`, the `INT/name` attribute with a single element `Nameless Certificate`. There **MUST NOT** be any other names nor any other attributes.

The choice to prohibit names is intentional, as it ensures that no implementation will be able to display an unverified name, thus forcing the user to keep an "address book" to associate each person to their certificate. 


## Revocation

# Proof of attribute

A PA, Proof of Attribute, is a short signed message that adds an attribute to the holder under the authority of the issuer.

Any one may issue a proof of attribute. The implementation **MUST NOT** attempt to verify of the issuer has "public faith" (i.e. what they say is assumed to be true by law). This task **MUST** be left to the user.

## Standard attributes

### INT/job

This **MUST NOT** be an array.

A simple trimmed one line string containing the subject's job title.

The job title **MUST NOT** include the name of the organization.

All apps **MUST** show the issuer's name and the job title of the attributes certificate together. 

Valid examples:

1. Consul
3. Questor
4. President
5. CEO
6. CEO, Cheif Executive Officer
8. Ministro
9. Ministro da 1ª turma

Wrong examples (organization **MUST NOT** be in the job title):

1. President of the US
2. Presidente da República
3. Justice of the Supreme Court
3. Presidente do Senado
4. Ministro da 1ª turma do Supremo Tribunal Federal

# Signatures

## Standard attributes

All signature attributes **MUST NOT** be arrays.

The `date`, `reason` and `implementation` attributes are **REQUIRED**. All others are OPTIONAL, but each country MAY require certain attributes.

Exactly one of the following **MUST** be present: `file` and `counter-signs`.

All implementations **MUST** counter sign instead of sign in parallel whenever possible. 

### reason

A dictionary that indicates why the signer is signing this document. Possible keys:

1. `as-document`: The signer role is set on the document itself and is not any sort of meta-role such as the ones below. This is the most common type of signature.
2. `sent`: The signer sent the document.
3. `created`: The signer created the document.
4. `approved`: The signer approved the document.
5. `rejected`: The signer rejected the document.
6. `delivered`: The signer placed the document where the recipient is expected to look regularly. Example: A server placed an email on the recipient's account.
7. `received`: The signer received the document. Example: a person counter-signs with this key to confirm they received an email.
8. `timestamp`: The signer testifies that the document existed at that moment in time.
9. `witness`: The signer testifies they saw the previous signings occur at the said time and without coercion.
10. `matches-original`: The signer testifies that the file being signed is an authentic copy/scan of the original physical document. 

All undefined values **MUST** be interpreted as false.

Apps **MUST NOT** add their own keys. 

Both the `approved` and `rejected` keys MAY be true at the same time. When this happens, it means that the signer approved a part of the document and rejected another. The user **MUST** be informed when this happens.

### location

A dictionary with the following keys:

1. `country`: A string with the country code.
2. `zip`: A string with the place's ZIP code equivalent according to the the country.
3. `lat`: A float in the interval [-90, +90] representing the latitude of the place.
4. `lon`: A float in the interval [-180, +180] representing the longitude of the place.
5. `state`: A string indicating the state or province of the place, preferably as a code. Examples: "DC" of District of Columbia, USA. "AP" for Amapá, Brazil.
6. `city`: The city or municipality of the place.
8. `street`: The street name.
9. `number`: A string (never a number) with the street number or name of the building.
10. `complement`: A string with the complement for the address.
11. `text`: A multi line string describing the place according to the rule sin the country. This is mainly intended for countries with different postal conventions.


The `country` key **MUST** be present. All others are **MAY** be empty.

`lat` and `lon` are mainly intended to automatically show markers on maps for the end user.

### date

A string with the time in which the signer claims to have signed the document.

All apps **MUST** warn the user that this value is just a claim which may be false.

### file

An object containing information about the file being signed.

```js
{
    "filename": "contract.txt",
    "size": 9007199254740991, // in bytes, 8 PiB in this case
    "had-file": false, // in this case the hash was NOT computed by the app that signed the message
    "hash": {
      "algorithm": "SHA-512",
      "value": "A69F73CCA23A9AC5C8B567DC185A756E97C982164FE25859E0D1DCC1475C80A615B2123AF1F5F94C11E3E9402C3AC558F500199D95B6D3E301758586281DCD26"
    }
}
```

A signature verification **MUST NOT** fail because the file was renamed.

### counter-signs

An array of base64 string encoding the previous signatures which the signer is countersigning.

### implementation

A string with the name and the version of the software used to generate the  signature. Both the name and the version **MUST** be included. Ex: `goJUDSYS 1.3.14`

In the case of application that use software libraries, both **MUST** be included. Ex: `MyApp 0.3.4; goJUDSYS 1.3.4`.

## Signature Request

# Internet APIs

## Online RESTful

### Sign certificate

Method: `POST`
Content-Type: `multipart/form-data`

URL: `<base url>/issue-cert/<long authorization token>`

Form: an [unsigned certificate](#unsigned-certificate) on name `unsigned-certificate`

Response: a [signed certificate](#signed-certificate).

### Certificate revocation status

Method: `GET`

URL: `<base url>/status/<any key id>`

Response (main part):

```js
{
  "key-id": "<key-id>",
  "revoked": true,
  "datetime": "2000-01-01T00:00:00"
}
```

### Time-stamps Authorities

## Browser interaction

# Smart-cards/Smart-phones

# Security and Usability Considerations

👉

## Graphical representation

Implementations **MUST NOT** show any representation of the signatures within the document. Ex: a scanned signature on a corner of a page is forbidden, but showing the signatures in a side panel is allowed.

## Mixing digital and paper signatures

The implementations **MUST NOT** encourage the user to print a digital document which already has signatures and add regular signatures to the printed version.

Rather, all paper signatures **MUST** be done first, then the document **SHOULD** be scanned by a notary or equivalent and then digital signatures may be added to the resulting file.   

## Dynamic Content

All signing apps **MUST** warn the user when the document they are trying to sign seems to have dynamic content.

All signing apps **MUST NOT** show the warning to the user if they have checked and failed to find signs of dynamic content on the file being signed.

If a signing app cannot verify the file for dynamic content and it is not on the white list, it **MUST** warn the user about the possibility of dynamic content.

For PDF, the verification, if implemented, **MUST** check for, and fail to find all of the following:

  1. Any signs of JavaScript.
  2. (👉 what else?)

For HTML, the verification, if implemented, **MUST** check for, and fail to find all of the following:

  1. The `<script>` tag.
  2. Properties such as `onclick` and `oninput` on any tags.
  3. External URLs for the tags `<link>` and `<style>`. Note that links, `<a>` tag, are fine regardless of the URL they point to and the `<script>` tag will fail the verification independently of the URL.
  4. (👉 anything else?)

Given the complexity some document formats, all implementations **MUST** warn the user that the document may contain dynamic content for the following formats:

  1. Office Open XML (MOX) and older Microsoft Office files (`.doc` ,`.dot` ,`.wbk` ,`.docx` ,`.docm` ,`.dotx` ,`.dotm` ,`.docb` ,`.xls` ,`.xlt` ,`.xlm` ,`.xlsx` ,`.xlsm` ,`.xltx` ,`.xltm` ,`.xlsb` ,`.xla` ,`.xlam` ,`.xll` ,`.xlw` ,`.ppt` ,`.pot` ,`.pps` ,`.pptx` ,`.pptm` ,`.potx` ,`.potm` ,`.ppam` ,`.ppsx` ,`.ppsm` ,`.sldx` ,`.sldm` ,`.pub` ,`.adn` ,`.accdb` ,`.accdr` ,`.accdt` ,`.accda` ,`.mdw` ,`.accde` ,`.mam` ,`.maq` ,`.mar` ,`.mat` ,`.maf` ,`.laccdb` ,`.ade` ,`.adp` ,`.mdb` ,`.cdb` ,`.mda` ,`.mdn` ,`.mdt` ,`.mdf` ,`.mde` ,`.ldb`) 
  2. Open Document Format for Office Applications (ODF) (`.odt`, `.fodt`, `.ods`, `.fods`, `.odp`, `.fodp`, `.odg`, `.fodg`, `.odf`).
  3. Adobe Flash files (`.flv`).
  4. Executable files (`.sh`, `.cmd`, `.bat`, `.exe`, `.dll`, `.so`, `.o`, `.a`, `.dylib`).

All signing apps **MAY** assume that the following file formats have no dynamic content:

  1. Image files, including JPEG (`.jpg` and `.jpeg`), PNG (`.png`), GIF (`.gif`), BMP (`.bmp`), WebP (`.webp`) and TIFF (`.tiff` and `.tif`).
  2. Text files, including pure text (`.txt`), rich text (`.rtf`), reStructured Text (`.rst`), Markdown (`.md`) and TeX files (`.tex`).
  3. Audio files, including `.mp3`, `.ogg`, `.wav`, `.3pg`, `.aac`, `.aiff`, `.m4a`.
  4. Video files, including `.avi`, `.mp4`, `.ogv`, `.mpeg`, `.webm` and `.mov`.

All signing apps **MUST** check extension in a case insensitive manner.


## Accidental changes 

👉 Decide how to handle the case of a user who opened a word file, accidentally added a new line and saved it. The best option seems to be mandatory PAR2 support.

## Archive files

👉 Decide how to handle the case of a user trying to sign a `.zip` or `.rar` file. Should they be warned about the fact the signature will only apply to all those files together instead of separately? 

## User misinterpretation and excessive trust on the machine

## Certificate and password sharing

## Cloud usage

The private keys **MUST** remain within the users control at all times. Cloud implementations **MUST NOT** have the users key on their servers, not even encrypted. 

## Side channel attacks

## Document replacement

# Language Specific Rules

## Portuguese

### Unicode Support

All apps aimed to support Portuguese **MUST** support the following Unicode blocks:

1. Basic Latin (U+0000..U+007F).
2. Latin-1 Supplement (U+00A0..U+00FF). This range excludes the need for supporting C1 Controls.

### Standard Translations

| English                         | Portuguese                              |
|---------------------------------|-----------------------------------------|
| Certificate                     | Certificado                             |
| (CA) Certificate Authority      | (AC) Autoridade Certificadora           |
| (PA) Proof of certificate       | (CA) Comprovante de Atributo            |
| (TA) Timestamping Authority     | (ACT) Autoridade de Carimbo de Tempo    |
| (PKI) Public Key Infrastructure | (ICP) Infraestrutura de Chaves Públicas |
| Subject                         | Titular                                 |
| Issuer                          | Emissor                                 |
| Hash                            | Resumo digital (hash)                   |

# Country Specific Rules

## Brazil

All certificates issued for natural persons **MUST** have the following attributes: 

  1. `BRA/CPF`
  2. `BRA/RG` or `BRA/RNE` or `INT/passports`: The certificate MAY have any combination of them so long as there is at least one.

For legal persons, the `INT/name` attribute **MUST** be the full "razão social".

Even if official documents show a name in all caps, all names **MUST** have propper capitalization. Ex: "Pedro de Alântara", not "PEDRO DE ALCÂNTARA" nor "Pedro De Alcântara".

All certificates issued for legal persons **MUST** have the following attributes: 

  1. `BRA/CNPJ`

For legal persons, they SHOULD also have, when possible:

  1. `BRA/IE` (inscrição estadual)
  2. `BRA/IM` (inscrição municipal)
  3. `BRA/NIRE` (junta comercial)

## Subject Attributes

### BRA/CPF

CPF (*Cadastro de Pessoas Físicas*) number. This **MUST** be encoded as a trimmed string with the format: `999.999.999/99`.

`BRA/CPF` **MUST NOT** be encoded as an array.

Example: `001.456.789/00`

All apps **MUST NOT** reject a BRA/CPF entry because the verification digits (the last two) are incorrect. 

### BRA/CNPJ

CNPJ (*Cadastro Nacional de Pessoas Jurídicas*) number. This **MUST** be encoded as a trimmed string with the format: `99.999.999/9999-99`.

`BRA/CNPJ` **MUST NOT** be encoded as an array.

Example: `01.012.123/0001-99`

All apps **MUST NOT** reject a `BRA/CNPJ` entry because the verification digits (the last two) are incorrect. 

### BRA/RNE

RNE (*Registro Nacional de Estrangeiros*) **MUST** be encoded as a string with all punctuation.

Example: 👉

### BRA/RGs

Each RG (*Registro Geral*) **MUST** be encoded as a dictionaries with the keys:

1. `number` for the RG number which **MUST** include punctuation.
2. `digit` for the verification digit, i.e. the character after the hyphen. If the subject RG has no digit this string **MUST** be empty.
3. `state` the two letter uppercase code for the federative unit that issued the document.
4. `issuer` the institution that actually issued the RG.
6. `short_form` a concise string expressing the main things about the RG. This **MUST** be present and **MUST** be computed by the CA using the following algorithm:

```pseudo
IF digit IS present THEN
    short_form = number + "-" + digit + " " + state
ELSE
    short_form = number + " " + state
END IF
```

Example of an RG:

```js
{
    // Number with punctuation
    "number": "12.345.678",
    // The character after the hyphen when present
    "digit": "X",
    // The issuing state (two letter upper case code)
    "state": "DF",
    // Issuing organization ("órgão emissor") with diacritics
    "issuer": "Secretaria de Segurança Pública",
    // number + " " + state (if digit == "")
    // number + "-" + digit + " " + state (if digit == "")
    "short_form": "12.345.678-X DF"
}
```

### BRA/Título de Eleitor

### BRA/NIT


{{json-schemas.md}}

{backmatter}

<reference anchor='ICAO-9303' target='https://www.icao.int/publications/Documents/9303_p3_cons_en.pdf'>
 <front>
 <title>Machine Readable Travel Documents, Seventh Edition</title>
  <author>
      <organization>International Civil Aviation Organization</organization>
  </author>
  <date year='2015'/>
 </front>
 </reference>

<reference anchor='JPEG-HOFF' target='https://magnushoff.com/jpeg-orientation.html'>
 <front>
 <title>JPEG Orientation: Working with the JPEG/EXIF orientation tag</title>
  <author fullname='Magnus Hovland Hoff' initials='M.' surname='Hoff'>
    <address>
      <email>maghoff@gmail.com</email>
      <uri>https://magnushoff.com/</uri>
  </address>
  </author>
  <date year='2015'/>
 </front>
 </reference>

<reference anchor='BR-MP2002' target='http://www.planalto.gov.brA/ccivil_03/MPV/Antigas_2001/2200-2.htm'>
 <front>
 <title>Medida Provisória № 2.200-2</title>
  <author>
      <organization>Federative Republic of Brazil</organization>
  </author>
  <date day='24' month='08' year='2001'/>
 </front>
 </reference>

<reference anchor='ITI-FAQ-21' target='http://www.iti.gov.brA/perguntas-frequentes/41-perguntas-frequentes/567-questoes-juridicas#r21'>
 <front>
 <title>Perguntas Frequentes - Questões Jurídicas - Questão 21</title>
  <author>
      <organization>ITI - Instituto Nacional de Tecnologia da Informação</organization>
  </author>
  <date day='5' month='02' year='2018'/>
 </front>
 </reference>
 
