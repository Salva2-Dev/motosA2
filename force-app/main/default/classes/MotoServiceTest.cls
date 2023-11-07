@isTest
private class MotoServiceTest {

    @isTest
    static void testGetFilteredModelos() {
        // GIVEN
        // Crea algunos modelos de prueba
        Modelo__c modelo1 = new Modelo__c(Name = 'Modelo 1', Precio__c = 1000, Cilindrada__c = 400, Marca__c = 'Marca A', Procedencia__c = 'China');
        Modelo__c modelo2 = new Modelo__c(Name = 'Modelo 2', Precio__c = 1500, Cilindrada__c = 400, Marca__c = 'Marca B', Procedencia__c = 'China');
        Modelo__c modelo3 = new Modelo__c(Name = 'Otro Modelo', Precio__c = 1200, Cilindrada__c = 400, Marca__c = 'Marca A', Procedencia__c = 'China');
        insert new List<Modelo__c>{modelo1, modelo2, modelo3};

        // WHEN
        Test.startTest();
        // Llama al método getFilteredModelos con el texto de búsqueda 'Modelo'
        List<Modelo__c> modelosFiltrados = MotoService.getFilteredModelos('Modelo');
        Test.stopTest();

        // THEN
        // Verifica que los modelos devueltos contengan 'Modelo' en el nombre
        for (Modelo__c modelo : modelosFiltrados) {
            System.assert(modelo.Name.contains('Modelo'), 'El nombre del modelo debe contener "Modelo"');
        }
    }
}
