# Naming conventions

**User**: A human being using a JUDSYS app. Unless otherwise specified, users MUST ALWAYS be considered as non-tech-savvy people.

**Signing app**: A computer program that digitally signs documents according to this standard.

**Verifier app**: A computer program that verifies a digital signature according to this standard.

(**App**) **JUDSYS app**: A computer program that is either a singing app or a verifier app or both.

**Subject qualifiers**: Certain values that qualify the subject. Ex: email, full name, government issued identification numbers, et cetera.

**Digital signature**:

(**PKI**) **Public Key Infrastructure**: 

(**KP**) **Key Pair**:

**Certificate**:

(**CA**) **Certificate Authority**: A certificate that is allowed to sign other certificates. This is, a CA is an entity (usually a company or government body) that ensures that the subject on a certificate is really the person it names. 

(**CAT**) **Attribute certificate**: A short signed message in which the issuer certifies that a certain attribute is true. Examples: job titles and permissions delegated by the issuer to the subject.

👉 Draft note: the use of the word "certificate" for two different things, certificates and attribute certificates, can lead to confusion. Some possible replacements for the expression "attribute certificate" are: "proof of attribute" and "attribute receipt".

All apps MUST use the standard translations present in this document when they present in the [Language specific rules](#language-specific-rules) section.


