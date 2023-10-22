import { LightningElement, api, wire } from 'lwc';
import getAllMod from '@salesforce/apex/MotoService.getAllModelos';

export default class MotosTile extends LightningElement {
   @api moto;
   @wire(getAllMod)
   motos;
}