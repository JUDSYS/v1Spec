---
title: JUDSYS-1
subtitle: "**J**SON **U**nified **D**igital **S**ignature S**y**stem **S**tandard - Version 1"
author: G. Queiroz <<gabrieljvnq@gmail.com>>
date: 2018
abstract: A simple digital signature standard designed to be used by regular people and to be of mandatory acceptance.
status: This version is a draft
status_color: red
---

# Introduction

# Who this document is for?

# Naming conventions

**User**: A human being using a JUDSYS app. Unless otherwise specified, users MUST ALWAYS be considered as non-tech-savvy people.

**Signing app**: A computer program that digitally signs documents according to this standard.

**Verifier app**: A computer program that verifies a digital signature according to this standard.

(**App**) **JUDSYS app**: A computer program that is either a singing app or a verifier app or both.

**Subject properties**: Certain values that qualify the subject. Ex: email, full name, government issued identification numbers, et cetera.

**Digital signature**:

(**PKI**) **Public Key Infrastructure**: 

(**KP**) **Key Pair**:

**Certificate**:

(**CA**) **Certificate Authority**: A certificate that is allowed to sign other certificates. This is, a CA is an entity (usually a company or government body) that ensures that the subject on a certificate is really the person it names. 

(**CAT**) **Attribute certificate**: A short signed message in which the issuer certifies that a certain attribute is true. Examples: job titles and permissions delegated by the issuer to the subject.

👉 Draft note: the use of the word "certificate" for two different things, certificates and attribute certificates, can lead to confusion. Some possible replacements for the expression "attribute certificate" are: "proof of attribute" and "attribute receipt".

## Standard Translations

| English               | Portuguese              |
|-----------------------|-------------------------|
| (CAT) Attribute certificate | (CAT) Comprovante de Atributo |
| Certificate | Certificado |
| (CA) Certificate Authority | (AC) Autoridade Certificadora |
| (PKI) Public Key Infrastructure | (ICP) Infraestrutura de Chaves Públicas |
| Subject | Titular |
| Issuer | Emissor |

Reasons for non literal translations:

  1. (**CAT**) **Comprovante de Atributo**: Using the word "certificado" in two different contexts can lead to confusion.

# Encoding

All JUDSYS-1 files are JSON encoded with UTF-8 in NFD (Normal Form Decomposition) or NFKD (Normal Form Compatibility Decomposition). The choice between either depends on the language of the text. When in doubt, use NFD.

To avoid canonicalization problems, all signed messages are encoded in base64.

Examples:

✏️

All countries or similar MUST be represented by the upper case two letter codes defined on ISO 3166-1. If a country or similar does not have such code, it MUST be full English name with spaces and proper capitalization. Ex: `Principality of Sealand` not `principality of sealand` nor `PrincipalityOf_Sealand`.

International organizations MUST use their upper case English acronym if it has more than two letters. Ex: `ICAO` and `ICJ`. Otherwise the full English name with spaces and capitalization MUST be used. Ex: `African Union`.

Special cases are:

  1. `UN` for the *United Nations* (already on the ISO 3166-1).
  1. `EU` for the *European Union* (already on the ISO 3166-1).
  1. `INT` for international things such as passports.
  1. `MERCOSU` for the *Southern Common Market*, *Mercosur* in Spanish and *Mercosul* in Portuguese.
  1. `UNASU` for the *Union of South American Nations*, *UNSAUR* in Spanish and *UNASUL* in Portuguese.
  1. `NAFTA` for the *North American Free Trade Agreement*.

All apps MUST NOT use fake international organizations, even if they were mentioned in presidential debates :)

## File extensions

All JUDSYS-1 extensions begin with `.j1` (dot, jay, one). 

All apps MUST use only the file extensions show below:

| Extension | Usage |
|-----------|-------|
| `.j1c` | Certificates (no private keys) |
| `.j1a` | Attribute certificates |
| `.j1k` | Certificates with the private keys |
| `.j1s` | Detached digital signature |
| `.j1e` | Encrypted file |
| `.j1r` | Revocation information |


# Certificates

✏️

## Subject Properties

### INT/emails

An array of the subject's email addresses.

If a user has an email address containing non ASCII character, the `INT/emails` array, there MUST be at least one ASCII only email address.

A subject MAY have no email address. In this case this property should be undefined or an empty array.

Examples:
```js
// Okay:
[]
["someone@example.com"]
["josé@construções-ltda.br", "jose@construcoes-ltda.br"]
["josé@construções-ltda.br", "jose@xn--construes-ltda-mjb8t.br"]
["josé@construções-ltda.br", "jose@construcoes-ltda.br", "josé@xn--construes-ltda-mjb8t.br"]
// This should NEVER be done:
["josé@construções-ltda.br"]
```

### INT/phones

For SPAM/robo-calling prevention the user MUST have the right to refuse the inclusion of the `INT/phone` property.

### INT/addresses

For security reasons the user MUST have the right to refuse the inclusion of `INT/address` property.

### INT/picture

For privacy reasons the user SHOULD have the right to refuse the inclusion of `INT/picture` property. The CA CAN require this property but its is encouraged not to require it.

### INT/passport

`INT/passport`: 
```
{

}
```

# Security Considerations

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

# Language specific rules

## Portuguese

The generation of the ASCII string variants MUST be done automatically by converting the string into NFKD and removing all non-ASCII characters. Code example (in Python 3):

```py
import unicodedata
print(unicodedata.normalize("NFKD", "João Pereira da Silva e Müller").
    encode("ascii", "ignore")) 
# b'Joao Pereira da Silva e Muller'
```

# Country specific rules

## Brazil

Remember that, as Portuguese speaking nation, the language specific rules for Portuguese MUST be used when handling Brazilian certificates. 

All certificates issued for natural persons MUST have the following attributes: 

  1. `BR/CPF`
  2. `BR/RG` or `BR/RNE` or `INT/Passport`: The certificate MAY have any combination of them so long as there is at least one.


All certificates issued for legal persons MUST have the following attributes: 

  1. `BR/CNPJ`

# Subject Properties

## BR/CPF

CPF (*Cadastro de Pessoas Físicas*) number. This MUST be encoded as a trimmed string with the format: `999.999.999/99`.

Example: `001.456.789/00`

All apps MUST NOT reject a BR/CPF entry because the verification digits (the last two) are incorrect. 

## BR/CNPJ

CNPJ (*Cadastro Nacional de Pessoas Jurídicas*) number. This MUST be encoded as a trimmed string with the format: `99.999.999/9999-99`.

Example: `01.012.123/0001-99`

## BR/RNE

RNE (*Registro Nacional de Estrangeiros*) MUST be encoded as a string with all punctuation.

Example: ✏️

## BR/RG

RG (*Registro Geral*) MUST be encoded as an array of dictionaries with the keys: `N`, `D`, `UF`, `O` and `O_ascii`. All of these values MUST be strings and MUST be present even if they are empty strings. The value for `N` MUST include punctuation except for the final hyphen. Example:

```js
{
    // Number with punctuation
    "N": "12.345.678",
    // The character after the hyphen when present
    "D": "9",
    // The issuing state (two letter upper case code)
    "UF": "SP",
    // Issuing organization ("órgão emissor") with diacritics
    "O": "Secretaria de Segurança Pública",
    // Issuing organization ("órgão emissor") without diacritics
    "O_ascii": "Secretaria de Seguranca Publica"

    /* Note that there is no need for ASCII variants for
    the N, D and UF as they will always contain only numbers,
    some punctuation and (rarely) upper case letters without diacritics.*/
}
```

### Special case: Multiple RGs

If a person has more than one RG and wishes to include them into the certificate, the CA MUST generate a certificate with a the "main RG" in the `BR/RG` parameter and all RGs (including the main one) MUST be on the `BR/RGs` parameter. This MUST be an array containing multiple dictionaries representing each RG the person has. Example:
    
```js
[
    {"N": "12.345.678", "D": "9", "UF": "SP", ...},
    {"N": "01.003.005", "D": "X", "UF": "RJ", ...}
]
```

Which RG will be the "main" one MUST be decided by the subject of the certificate.
