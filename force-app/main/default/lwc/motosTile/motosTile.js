import { LightningElement, api, } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';


export default class MotosTile extends NavigationMixin(LightningElement) {
   @api moto;

   get Europea(){
      return  this.moto.Procedencia__c.includes("Europea");
   }

   get Japonesa(){
      return  this.moto.Procedencia__c.includes("Japonesa");
   }

   navigateToRecordViewPage() {
      // View a custom object record.
      this[NavigationMixin.Navigate]({
        type: "standard__recordPage",
        attributes: {
          recordId: this.moto.Id,
          objectApiName: "namespace__ObjectName", // objectApiName is optional
          actionName: "view",
        },
      });
    }

   }


//moto.Procedencia__c   Europea Japonesa China