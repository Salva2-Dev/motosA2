@isTest
private with sharing class MotoFrecuenciaTest {
    
    @isTest 
    static void testGetDiasRevision() {
        // Crea un objeto Modelo__c con frecuencia de revisión de 365 días
        Modelo__c modelo = new Modelo__c(Frecuencia_Revision__c = 365);

        // Llama al método estático de la clase MotoFrecuencia para obtener la frecuencia de revisión
        Integer days = MotoFrecuencia.getDiasRevision(modelo);

        // Define el valor esperado de la frecuencia de revisión
        Integer expectedDays = 365;

        // Verifica que el resultado obtenido sea igual al valor esperado
        System.assertEquals(expectedDays, days, 'La frecuencia de revisión debe ser 365 días');
    }

    @isTest 
    static void getDiasCambioAceite() {
        // Crea un objeto Modelo__c con frecuencia de revisión de 365 días
        Modelo__c modelo = new Modelo__c(Frecuencia_Cambio_Aceite__c = 365);

        // Llama al método estático de la clase MotoFrecuencia para obtener la frecuencia de revisión
        Integer days = MotoFrecuencia.getDiasCambioAceite(modelo);

        // Define el valor esperado de la frecuencia de revisión
        Integer expectedDays = 365;

        // Verifica que el resultado obtenido sea igual al valor esperado
        System.assertEquals(expectedDays, days, 'La frecuencia del cambio de aceite debe ser 365 días');
    }
}