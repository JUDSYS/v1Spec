## Brazil

All certificates issued for natural persons MUST have the following attributes: 

  1. `BR/CPF`
  2. `BR/RG` or `BR/RNE` or `INT/passport`: The certificate MAY have any combination of them so long as there is at least one.

For legal persons, the `INT/name` attribute MUST be the full "razão social".

Even if official documents show a name in all caps, all names MUST have propper capitalization. Ex: "Pedro de Alântara", not "PEDRO DE ALCÂNTARA" nor "Pedro De Alcântara".

All certificates issued for legal persons MUST have the following attributes: 

  1. `BR/CNPJ`

For legal persons, they SHOULD also have, when possible:

  1. `BR/IE` (inscrição estadual)
  2. `BR/IM` (inscrição municipal)
  3. `BR/NIRE` (junta comercial)

## Subject Attributes

### BR/CPF

CPF (*Cadastro de Pessoas Físicas*) number. This MUST be encoded as a trimmed string with the format: `999.999.999/99`.

`BR/CPF` MUST NOT be encoded as an array.

Example: `001.456.789/00`

All apps MUST NOT reject a BR/CPF entry because the verification digits (the last two) are incorrect. 

### BR/CNPJ

CNPJ (*Cadastro Nacional de Pessoas Jurídicas*) number. This MUST be encoded as a trimmed string with the format: `99.999.999/9999-99`.

`BR/CNPJ` MUST NOT be encoded as an array.

Example: `01.012.123/0001-99`

All apps MUST NOT reject a `BR/CNPJ` entry because the verification digits (the last two) are incorrect. 

### BR/RNE

RNE (*Registro Nacional de Estrangeiros*) MUST be encoded as a string with all punctuation.

Example: ✏️

### BR/RG

RG (*Registro Geral*) MUST be encoded as an array of dictionaries with the keys:

1. `number` for the RG number which MUST include punctuation.
2. `digit` for the verification digit, i.e. the character after the hyphen. If the subject RG has no digit this string MUST be empty.
3. `state` the two letter uppercase code for the federative unit that issued the document.
4. `issuer` the institution that actually issued the RG.
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
    // number + " " + state (if digit == "")
    // number + "-" + digit + " " + state (if digit == "")
    "short_form": "12.345.678-X DF"
}
```

### BR/Título de Eleitor

### BR/NIT


