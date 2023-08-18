let listaRepositorios = localStorage.getItem('dbRepositorios') ? JSON.parse(localStorage.getItem('dbRepositorios')) : []
//localStorage.setItem('dbRepositorios', JSON.stringify(listaRepositorios))
//const listaRepositorios = JSON.parse(localStorage.getItem('dbRepositorios'))
const select = document.querySelector('#P3_LML_AGRUPSEMANAL')
const options = select.children;

const btSalvar = document.querySelector('#B56036584827854032')
const btRemover = document.querySelector('#B56036643823854033')
//const btAdiconar = document.querySelectorAll("input[value=Adicionar]");


//console.log(btAdiconar); 

/*Events */
select.addEventListener('change', handleRepositorios);
btSalvar.addEventListener('click', handleSalvarLista);
btRemover.addEventListener('click', () => localStorage.removeItem('dbRepositorios'));

console.log(listaRepositorios)

carregarLista()
/*-------------------------------------------------- */

/*Methods */
function handleRepositorios(e)
{
      
    let val = e.target.value;
    let rep = val.split('-');
    let result = rep[0].replace('[','')
    result = result.replace(']','')
           
     const params = result.split(' ')
     /*
      params[0] --> ID do repositório
      params[1] --> Centro de custo
      params[2] --> tipo do repositório
     */           
           
    console.log(params[0],params[1],params[2])
   
    
    apex.item('P3_PARAMS').setValue(params[0])
    //salvarRepositorioTemporario(params[0] + ' ' +params[1] + ' ' + ' '+ params[2] )
    //localStorage.setItem('dbRepositorios', JSON.stringify(listaRepositorios))         
}

function handleSalvarLista(evt)
{
    evt.preventDefault()
    if (listaRepositorios.length > 0)
          listaRepositorios = []
    //alert('Das ist eine klain test')
    console.log(options)
    for(let i=0; i<options.length; i++)
    {
        console.log(options[i].innerHTML)
        listaRepositorios.push(options[i].innerHTML)
    }
    localStorage.setItem('dbRepositorios', JSON.stringify(listaRepositorios))
}

//const handleApagarLista = () => localStorage.removeItem('dbRepositorios');

function carregarLista()
{
    if (listaRepositorios.length > 0)
          listaRepositorios.forEach(rep => montarLista(rep))
}

function montarLista(repositorio) {
     let opt = document.createElement('option')
     opt.value = repositorio
     opt.innerText = repositorio
     select.append(opt)
}