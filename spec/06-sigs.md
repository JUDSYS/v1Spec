# Signatures

## Standard attributes

All signature attributes MUST NOT be arrays.

The `INT/date` and `INT/reason` attributes are MANDATORY. All others are OPTIONAL, but each country MAY require certain attributes.

### INT/reason

A dictionary that indicates why the signer is signing this document. Possible keys:

1. `sent`: The signer sent the document.
2. `created`: The signer created the document.
3. `approved`: The signer approved the document (this is the most common type signature).
4. `rejected`: The signer rejected the document.
5. `delivered`: The signer placed the document where the recipient is expected to look regularly. Example: A server placed an email on the recipient's account.
6. `received`: The signer received the document. Example: a person counter-signs with this key to confirm they received an email.
7. `timestamp`: The signer testifies that the document existed at that moment in time. (Only TAs may do this)
8. `witness`: The signer testifies they saw the previous signings occur at the said time and without coercion.

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

### INT/file

An object containing information about the file being signed.

```js
{
    "filename": "contract.txt",
    "size": 9007199254740991, // in bytes, 8 PiB in this case
    "hash": "SHA-3-512=A69F73CCA23A9AC5C8B567DC185A756E97C982164FE25859E0D1DCC1475C80A615B2123AF1F5F94C11E3E9402C3AC558F500199D95B6D3E301758586281DCD26"
}
```

A signature verification MUST NOT fail because the file was renamed.

### INT/counter

An array of base64 string encoding the previous signatures.

```js
["ewogICAgImZpbGVuYW1lIjogImNvbnRyYWN0LnR4dCIsCiAgICAiaGFzaCI6ICJTSEEtMy01MTI9QTY5RjczQ0NBMjNBOUFDNUM4QjU2N0RDMTg1QTc1NkU5N0M5ODIxNjRGRTI1ODU5RTBEMURDQzE0NzVDODBBNjE1QjIxMjNBRjFGNUY5NEMxMUUzRTk0MDJDM0FDNTU4RjUwMDE5OUQ5NUI2RDNFMzAxNzU4NTg2MjgxRENEMjYiCn0K"]
```

A signature verification MUST NOT fail because the file was renamed.

## Signature Resquest
