/* nav.js — общий навигационный слой мини-сайта Reversa Docs.
   Работает через file:// без fetch. Источник навигации — window.RV_DATA.nav
   (инжектится data.js до этого скрипта). Если data.js не загрузился,
   используется статический <nav>, уже заполненный Publisher на этапе сборки.
   Задачи: подсветить текущую страницу (aria-current) и включить переключатель темы. */
(function(){
  "use strict";

  function currentPageId(){
    var b = document.body;
    if(b && b.getAttribute('data-page')) return b.getAttribute('data-page');
    var p = location.pathname.split('/').pop() || 'index.html';
    return p.replace(/\.html$/,'') || 'index';
  }

  // Подсветка активной ссылки в каждом <nav class="reversa-doc-nav">.
  function markActive(){
    var pid = currentPageId();
    // feature-страницы помечают активным раздел "modulos"
    var normalized = pid.indexOf('feature-') === 0 ? 'modulos' : pid;
    var navs = document.querySelectorAll('nav.reversa-doc-nav');
    for(var n=0;n<navs.length;n++){
      var links = navs[n].querySelectorAll('a');
      for(var i=0;i<links.length;i++){
        var a = links[i];
        var id = a.getAttribute('data-page-id') || '';
        if(id === normalized || (normalized === 'index' && id === 'index')){
          a.setAttribute('aria-current','page');
        } else {
          a.removeAttribute('aria-current');
        }
      }
    }
  }

  // Переключатель темы: добавляет/снимает класс rv-theme-light на <html>.
  function wireThemeToggle(){
    var btns = document.querySelectorAll('.theme-toggle');
    if(!btns.length) return;
    var KEY = 'rv-docs-theme';
    var stored = null;
    try{ stored = window.localStorage ? localStorage.getItem(KEY) : null; }catch(e){ stored = null; }
    if(stored === 'light'){ document.documentElement.classList.add('rv-theme-light'); }
    function toggle(){
      var light = document.documentElement.classList.toggle('rv-theme-light');
      try{ if(window.localStorage) localStorage.setItem(KEY, light ? 'light' : 'dark'); }catch(e){}
    }
    for(var i=0;i<btns.length;i++){
      btns[i].addEventListener('click', toggle);
    }
  }

  function init(){ markActive(); wireThemeToggle(); }

  if(document.readyState === 'loading'){
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
