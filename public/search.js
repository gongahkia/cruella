// Lunr.js powered client-side search over index.json
(function(){
  function init(){
    const input=document.getElementById('searchInput');
    const results=document.getElementById('searchResults');
    if(!input||!results||!window.lunr) return;
    fetch('index.json').then(r=>r.json()).then(data=>{
      const byId={};
      const documents=data.map((d,i)=>{
        const id=String(i);
        const tags=(d.tags||'').split(',').map(s=>s.trim()).filter(Boolean);
        const doc={id,title:d.title,file:d.file,description:d.description||'',tags,content:d.content||''};
        byId[id]=doc; return doc;
      });
      const idx=lunr(function(){
        this.ref('id');
        this.field('title');
        this.field('description');
        this.field('tags');
        this.field('content');
        documents.forEach(d=>this.add({
          id:d.id,
          title:d.title,
          description:d.description,
          tags:d.tags.join(' '),
          content:d.content
        }));
      });
      input.addEventListener('input',()=>{
        const q=input.value.trim();
        results.innerHTML='';
        if(!q) return;
        let res=[];
        try{ res=idx.search(q); }catch(e){ res=[]; }
        res.slice(0,12).forEach(hit=>{
          const d=byId[hit.ref];
          const li=document.createElement('li');
          const tags=d.tags.length?`<small> · ${d.tags.join(', ')}</small>`:'';
          li.innerHTML=`<a href="${d.file}">${d.title}</a>${tags}`;
          results.appendChild(li);
        });
      });
    }).catch(()=>{});
  }
  if(document.readyState==='loading') document.addEventListener('DOMContentLoaded',init); else init();
})();
