## Brazil

All certificates issued for natural persons MUST have the following attributes: 

  1. `BR/CPF`
  2. `BR/RG` or `BR/RNE` or `INT/passport`: The certificate MAY have any combination of them so long as there is at least one.

All certificates issued for legal persons MUST have the following attributes: 

  1. `BR/CNPJ`

For legal persons, they SHOULD also have, when possible:

  1. `BR/IE` (inscrição estadual)
  2. `BR/IM` (inscrição municipal)
  3. `BR/NIRE` (junta comercial)

## Subject Attributes

### BR/CPF

CPF (*Cadastro de Pessoas Físicas*) number. This MUST be encoded as a trimmed string with the format: `999.999.999/99`.

Example: `001.456.789/00`

All apps MUST NOT reject a BR/CPF entry because the verification digits (the last two) are incorrect. 

### BR/CNPJ

CNPJ (*Cadastro Nacional de Pessoas Jurídicas*) number. This MUST be encoded as a trimmed string with the format: `99.999.999/9999-99`.

Example: `01.012.123/0001-99`

### BR/RNE

RNE (*Registro Nacional de Estrangeiros*) MUST be encoded as a string with all punctuation.

Example: ✏️

### BR/RG

RG (*Registro Geral*) MUST be encoded as a dictionary with the keys:

1. `number` for the RG number which MUST include punctuation.
2. `digit` for the verification digit, i.e. the character after the hyphen. If the subject RG has no digit this string MUST be empty.
3. `state` the two letter uppercase code for the federative unit that issued the document.
4. `issuer` the institution that actually issued the RG.
5. `issuer_ascii` same as `issue` but using only ASCII characters.
6. `short_form` a concise string expressing the main things about the RG. The following algorithm MUST be used:
```psuedo
IF digit IS present THEN
    short_form = number + "-" + digit + " /" + state
ELSE
    short_form = number + " /" + state
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
    // Issuing organization ("órgão emissor") without diacritics
    "issuer_ascii": "Secretaria de Seguranca Publica",
    // number + " " + state (if digit == "")
    // number + "-" + digit + " " + state (if digit == "")
    "short_form": "12.345.678-X DF"

    /* Note that there is no need for ASCII variants for
    the number, digit and state as they will always contain only numbers,
    some punctuation and (rarely) upper case letters without diacritics.*/
}
```

#### Special case: Multiple RGs

If a person has more than one RG and wishes to include them into the certificate, the CA MUST generate a certificate with a the "main RG" in the `BR/RG` subject attribute and all RGs (including the main one) MUST be on the `BR/RGs` attribute. This MUST be an array containing multiple dictionaries representing each RG the person has. Example:
    
```js
[
    {"short_form": "12.345.678-9 SP", "state": "SP", ...},
    {"short_form": "01.003.005-X RJ", "state": "RJ", ...}
]
```

Which RG will be the "main" one MUST be decided by the subject of the certificate.

### BR/Título de Eleitor

### BR/NIT