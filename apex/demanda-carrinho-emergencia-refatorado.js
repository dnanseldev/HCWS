/*Daniel Anselmo - 25-07-2023 */

class ConfigurarComponentesSemana {
    
    constructor(select, btSalvar, btRemover, storageName, itemParametro)
    {
        this.listaRepositorios = localStorage.getItem(storageName) ? JSON.parse(localStorage.getItem(storageName)) : []
        this.select =  document.querySelector(select);
        this.options = this.select.children;
        this.btSalvar =  document.querySelector(btSalvar);
        this.btRemover = document.querySelector(btRemover);
        this.storageName = storageName; 
        this.itemParametro = itemParametro
        this.startUp();
    }   

    startUp()
    {
        this.select.addEventListener('change', evt => this.handleRepositorios(evt, this.itemParametro));
        this.btSalvar.addEventListener('click', this.handleSalvarLista.bind(this));
        this.btRemover.addEventListener('click', () => localStorage.removeItem(storageName));
    }

    handleRepositorios(e, itemParametro)
    {
      
        let val = e.target.value;
        let rep = val.split('-');
        let result = rep[0].replace('[','');
        result = result.replace(']','');            
        const params = result.split(' ');
        /*
        params[0] --> ID do repositório
        params[1] --> Centro de custo
        params[2] --> tipo do repositório
        */         
            
        console.log(params[0],params[1],params[2])        
        apex.item(itemParametro).setValue(params[0])            
    }

    handleSalvarLista()
    {        
        if (this.listaRepositorios.length > 0)
            this.listaRepositorios = []
        
        console.log(this.options)
        for(let i=0; i<this.options.length; i++)
        {
            console.log(this.options[i].innerHTML)
            this.listaRepositorios.push(this.options[i].innerHTML)
        }
        localStorage.setItem(this.storageName, JSON.stringify(this.listaRepositorios))
    }

    carregarLista()
    {
        if (this.listaRepositorios.length > 0)
            this.listaRepositorios.forEach(rep => this.montarLista(rep))
    }

    montarLista(repositorio)
    {
        let opt = document.createElement('option')
        opt.value = repositorio
        opt.innerText = repositorio
        this.select.append(opt)
    }
}

/*Inicialização dos componentes*/
const semana01 = new ConfigurarComponentesSemana(
            '#P3_LML_AGRUPSEMANAL','#B56036584827854032'
            ,'#B56036643823854033','dbRepositorios', 'P3_PARAMS');
         
semana01.carregarLista();

const semana02 = new ConfigurarComponentesSemana(
            '#P3_LML_AGRUPSEMANAL_2','#B56036889515854035'
            ,'#B56036934538854036','dbRepositorios2', 'P3_PARAMS_2')
                
semana02.carregarLista()

const semana03 = new ConfigurarComponentesSemana(
            '#P3_LML_AGRUPSEMANAL_3','#B59458914328053704'
            ,'#B59459075713053705','dbRepositorios3', 'P3_PARAMS_3');
                
semana03.carregarLista()

const semana04 = new ConfigurarComponentesSemana(
            '#P3_LML_AGRUPSEMANAL_4','#B59460665864053721'
            ,'#B59460727499053722','dbRepositorios4', 'P3_PARAMS_4' )
                
semana04.carregarLista()
