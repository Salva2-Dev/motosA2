@isTest
private with sharing class MotoTriggerTest {

    @isTest
    static void testInsertTrigger() {
        // GIVEN
        Modelo__c modelo = new Modelo__c(Frecuencia_Revision__c = 365, Frecuencia_Cambio_Aceite__c = 365,  Marca__c = 'Honda', Cilindrada__c = 400, Precio__c = 1000, Procedencia__c = 'China');
        insert modelo;

        Mi_moto__c miMoto1 = new Mi_moto__c(Modelo__c = modelo.Id, Ultima_Revision__c = Date.today(), Ultimo_Cambio_De_Aceite__c = Date.today());

        // WHEN
        Test.startTest();
        insert miMoto1;
        Test.stopTest();

        // THEN
        // Verificar que la próxima revisión y el próximo cambio de aceite se hayan calculado correctamente después de la inserción
        miMoto1 = [SELECT Id, Proxima_Revision__c, Ultima_Revision__c, Ultimo_Cambio_De_Aceite__c, Proximo_Cambio_De_Aceite__c FROM Mi_moto__c WHERE Id = :miMoto1.Id LIMIT 1];

        // Calcular las fechas esperadas
        Date expectedNextRevision = miMoto1.Ultima_Revision__c.addDays(MotoFrecuencia.getDiasRevision(modelo));
        Date expectedNextOilChange = miMoto1.Ultimo_Cambio_De_Aceite__c.addDays(MotoFrecuencia.getDiasCambioAceite(modelo));

        // Verificar que las fechas calculadas sean las esperadas
        System.assertEquals(expectedNextRevision, miMoto1.Proxima_Revision__c, 'La próxima revisión debe ser calculada correctamente');
        System.assertEquals(expectedNextOilChange, miMoto1.Proximo_Cambio_De_Aceite__c, 'El próximo cambio de aceite debe ser calculado correctamente');
    }

    @isTest
static void testUpdateTrigger() {
    // GIVEN
    Modelo__c modelo = new Modelo__c( Frecuencia_Revision__c = 365, Frecuencia_Cambio_Aceite__c = 90, Marca__c = 'Honda', Cilindrada__c = 400, Precio__c = 1000, Procedencia__c = 'China');
    insert modelo;

    Mi_moto__c miMoto = new Mi_moto__c(Modelo__c = modelo.Id, Ultima_Revision__c = Date.today(), Ultimo_Cambio_De_Aceite__c = Date.today());
    insert miMoto;

    // WHEN
    Test.startTest();
    // Actualizar la fecha de última revisión y último cambio de aceite
    miMoto = [SELECT Id, Ultima_Revision__c, Ultimo_Cambio_De_Aceite__c FROM Mi_moto__c WHERE Id = :miMoto.Id LIMIT 1];
    miMoto.Ultima_Revision__c = Date.today().addDays(30);
    miMoto.Ultimo_Cambio_De_Aceite__c = Date.today().addDays(15);
    update miMoto;
    Test.stopTest();

    // THEN
    // Verificar que la próxima revisión y el próximo cambio de aceite se hayan recalculado correctamente después de la actualización
    miMoto = [SELECT Id, Proxima_Revision__c, Proximo_Cambio_De_Aceite__c, Ultima_Revision__c, Ultimo_Cambio_De_Aceite__c FROM Mi_moto__c WHERE Id = :miMoto.Id LIMIT 1];

    // Calcular las fechas esperadas después de la actualización
    Date expectedNextRevision = miMoto.Ultima_Revision__c.addDays(MotoFrecuencia.getDiasRevision(modelo));
    Date expectedNextOilChange = miMoto.Ultimo_Cambio_De_Aceite__c.addDays(MotoFrecuencia.getDiasCambioAceite(modelo));

    // Verificar que las fechas recalculadas sean las esperadas después de la actualización
    System.assertEquals(expectedNextRevision, miMoto.Proxima_Revision__c, 'La próxima revisión debe ser recalculada correctamente después de la actualización');
    System.assertEquals(expectedNextOilChange, miMoto.Proximo_Cambio_De_Aceite__c, 'El próximo cambio de aceite debe ser recalculado correctamente después de la actualización');
}
}
