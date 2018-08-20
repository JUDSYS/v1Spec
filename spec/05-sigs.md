# Signatures

## Standard attributes

All signature attributes MUST NOT be arrays.

The `INT/date` and `INT/reason` attributes are MANDATORY. All others are OPTIONAL, but each country MAY require certain attributes.

### INT/reason

A dictionary that indicates why the signer is signing this document. Possible keys:

1. `sent`: The signer sent the document.
2. `created`: The signer created the document.
3. `approved`: The signer approved the document.
4. `rejected`: The signer rejected the document.
4. `delivered`: The signer placed the document where the recipient is expected to look regularly. Example: A server placed an email on the recipient's account.
5. `received`: The signer received the document. Example: a person counter-signs with this key to confirm they received an email.

All undefined values MUST be interpreted as false.

Apps MUST NOT add their own keys. 

Both the `approved` and `rejected` keys MAY be true at the same time. When this happens, it means that the signer approved a part of the document and rejected another. 

### INT/location

A dictionary with the following keys:

1. `country`: A string with the country code.
2. `zip`: A string with the place's ZIP code equivalent according to the the country.
3. `lat`: A float representing the latitude of the place.
4. `lon`: A float representing the longitude of the place.
5. `state`: A string indicating the state or province of the place, preferably as a code. Examples: "DC" of District of Columbia, USA. "AP" for Amapá, Brazil.
6. `city`: The city or municipality of the place.
7. `street`: The street name.
8. `number`: A string with the street number or name of the building.
9. `complement`: A complement for the address.
10. `text`: A multi line string describing the place according to the rule sin the country. This is mainly intended for countries with different postal conventions.

Except for `country` which is MANDATORY, all other keys are OPTIONAL.

`lat` and `lon` are mainly intended to automatically show markers on maps for the end user.

### INT/date

A string with the time in which the signer claims to have signed the document.

All apps MUST warn the user that this value is just a claim which may be false.

### INT/comments

A string with comments about the signature, preferably in the signer's language.

This is discouraged and MUST only be used when there are no better alternatives.

### INT/timestamp

A string with the time in which the TSA received the document.

All apps MUST verify if the signer was authorized to issue timestamps before show this attribute to the user.