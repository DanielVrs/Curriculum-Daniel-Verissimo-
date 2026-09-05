# Currículo — Daniel Verissimo

Currículo online em HTML, CSS e JavaScript puro, sem framework nem build.
Publicado como site estático (Vercel, GitHub Pages ou qualquer hospedagem de arquivos).

## Estrutura

```
index.html     conteúdo do currículo (PT-BR, com tradução EN em data-en)
style.css      layout lateral + conteúdo, responsivo e regras de impressão
script.js      seletor PT/EN (salva a escolha no localStorage)
gerar-pdf.sh   regenera os dois PDFs a partir do site (Chrome headless)
assets/
  perfil.jpg                   foto de perfil (quadrada)
  Daniel-Verissimo-CV.pdf      PDF em português (botão "Baixar PDF")
  Daniel-Verissimo-CV-EN.pdf   PDF em inglês (mesmo botão, com o site em EN)
```

## Como rodar

Basta abrir o `index.html` no navegador. Pra servir localmente:

```bash
python3 -m http.server 8080
# http://localhost:8080
```

## Como editar

- **Texto**: tudo fica no `index.html`. Cada trecho traduzível tem um atributo
  `data-en="..."` com a versão em inglês. Editou o português, edite o inglês junto.
- **Paleta**: tokens `--g-*` (verdes) e `--mint-*` (fundos claros) no topo do `style.css`.
  A barra lateral usa `--side-*`, que também são trocados automaticamente na impressão.
- **Fontes**: Sora (títulos) e Manrope (texto), carregadas do Google Fonts no `index.html`.
- **Foto**: substituir `assets/perfil.jpg` (quadrada, 400x400 ou maior).
- **PDF**: os dois PDFs são gerados do próprio site. Depois de editar o conteúdo,
  rode `./gerar-pdf.sh` (usa o Chrome instalado ou o do cache do Puppeteer;
  aceita `CHROME=/caminho/chrome`). Ctrl+P no navegador gera o mesmo resultado,
  pelas regras `@media print` em A4.

## Deploy na Vercel

Importar o repositório na Vercel com framework "Other". Não precisa de build
command nem de output directory: a raiz já é o site.
