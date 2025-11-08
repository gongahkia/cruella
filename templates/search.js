// Simple client-side substring search over index.json
(function(){
  function init(){
    const input=document.getElementById('searchInput');
    const results=document.getElementById('searchResults');
    if(!input||!results) return;
    fetch('index.json').then(r=>r.json()).then(data=>{
      input.addEventListener('input',()=>{
        const q=input.value.trim().toLowerCase();
        results.innerHTML='';
        if(!q) return;
        data.filter(d=>d.content.toLowerCase().includes(q)||d.title.toLowerCase().includes(q))
            .slice(0,12)
            .forEach(d=>{
              const li=document.createElement('li');
              li.innerHTML='<a href="'+d.file+'">'+d.title+'</a>';
              results.appendChild(li);
            });
      });
    }).catch(()=>{});
  }
  if(document.readyState==='loading') document.addEventListener('DOMContentLoaded',init); else init();
})();
