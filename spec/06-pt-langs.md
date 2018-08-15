## Portuguese

The generation of the ASCII string variants MUST be done automatically by converting the string into NFKD and removing all non-ASCII characters. Code example (in Python 3):

```py
import unicodedata
print(unicodedata.normalize("NFKD", "João Pereira da Silva e Müller").
    encode("ascii", "ignore")) 
# b'Joao Pereira da Silva e Muller'
```

### Standard Translations

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

