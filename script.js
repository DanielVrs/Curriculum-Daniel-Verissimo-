/*
 * Alternância PT-BR / EN.
 * Todo elemento com data-en="..." guarda a versão em inglês do seu conteúdo.
 * Ao trocar pra EN, o HTML original (PT) é salvo em data-pt e restaurado ao voltar.
 * A escolha fica salva no localStorage (chave cv-lang).
 */
(function () {
  var buttons = document.querySelectorAll('.lang-btn');
  var els = document.querySelectorAll('[data-en]');

  function setLang(lang) {
    els.forEach(function (el) {
      if (lang === 'en') {
        if (el.dataset.pt == null) el.dataset.pt = el.innerHTML;
        el.innerHTML = el.dataset.en;
      } else if (el.dataset.pt != null) {
        el.innerHTML = el.dataset.pt;
      }
    });
    document.documentElement.lang = (lang === 'en') ? 'en' : 'pt-BR';
    document.title = (lang === 'en')
      ? 'Daniel Verissimo — Full-Stack Developer'
      : 'Daniel Verissimo — Desenvolvedor Full Stack';
    // o botão de PDF aponta pro arquivo do idioma ativo
    var pdf = document.getElementById('pdf-link');
    if (pdf) {
      pdf.href = (lang === 'en') ? 'assets/Daniel-Verissimo-CV-EN.pdf' : 'assets/Daniel-Verissimo-CV.pdf';
      pdf.download = (lang === 'en') ? 'Daniel-Verissimo-CV-EN.pdf' : 'Daniel-Verissimo-CV.pdf';
    }
    buttons.forEach(function (b) {
      var on = b.dataset.lang === lang;
      b.classList.toggle('is-on', on);
      b.setAttribute('aria-pressed', on ? 'true' : 'false');
    });
    try { localStorage.setItem('cv-lang', lang); } catch (e) {}
  }

  buttons.forEach(function (b) {
    b.addEventListener('click', function () { setLang(b.dataset.lang); });
  });

  var saved;
  try { saved = localStorage.getItem('cv-lang'); } catch (e) {}
  setLang(saved === 'en' ? 'en' : 'pt');
})();
