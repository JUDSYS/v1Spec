# Naming conventions

**User**: A human being using a JUDSYS app. Unless otherwise specified, users MUST ALWAYS be considered as non-tech-savvy people.

**Signing app**: A computer program that digitally signs documents according to this standard.

**Verifier app**: A computer program that verifies a digital signature according to this standard.

(**App**) **JUDSYS app**: A computer program that is either a singing app or a verifier app or both.

**Subject qualifiers**: Certain values that qualify the subject. Ex: email, full name, government issued identification numbers, et cetera.

**Natrual person**: A human beign.

**Legal person**: A group of people who the Law considers to be its own person. 

**Digital signature**:

(**PKI**) **Public Key Infrastructure**: 

(**KP**) **Key Pair**:

**Certificate**:

(**CA**) **Certificate Authority**: A certificate that is allowed to sign other certificates. This is, a CA is an entity (usually a company or government body) that ensures that the subject on a certificate is really the person it names. 

(**CAT**) **Attribute certificate**: A short signed message in which the issuer certifies that a certain attribute is true. Examples: job titles and permissions delegated by the issuer to the subject.

**CAT chain**: a chain of attribute certificates that allows the final issuer to do so.

👉 Draft note: the use of the word "certificate" for two different things, certificates and attribute certificates, can lead to confusion. Some possible replacements for the expression "attribute certificate" are: "proof of attribute" and "attribute receipt".

All apps MUST use the standard translations present in this document when they present in the [Language specific rules](#language-specific-rules) section.

## Glossary and Acronymuns

**ASCII**: *American Standard Code for Information Interchange*. A text encoding that uses 7 bits to encode all upper and lower case English letters as well as digits 0 to 9, some punctuation, some special characters and a few control characters.

**ICAO**: *International Civil Aviation Organization*.

**JSON**: *Javascript Object Notation*.

**Unicode**: A system that attempts to encode almost all characters ever used by humanity for writing so they can be used togheter in same piece of text. Example: "Á ç Д ħ 💻 ﺙ 𓁡 𒉲 ウ ⺝ "

**UTF-8**: An Unicode encoding that is ASCII compatible. Some characters will require more bytes, other less.


