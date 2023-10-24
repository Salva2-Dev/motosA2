import { LightningElement, api, wire } from 'lwc';
import getFilteredModelos from '@salesforce/apex/MotoService.getFilteredModelos';

export default class MotosTile extends LightningElement {
   searchText = "";
   @api moto;
   @wire(getFilteredModelos, {searchText: '$searchText'})
   motos;

   handleInputChange(event){
const searchTextAux = event.target.value;
if (searchTextAux.length >=2 || searchTextAux === ""){
this.searchText = searchTextAux;
}
   }
}