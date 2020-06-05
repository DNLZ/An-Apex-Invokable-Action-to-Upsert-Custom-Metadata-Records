public without sharing class UpsertCustomMetadataRecordAction {
    @InvocableMethod(label='Upsert Custom Metadata Records' description='Upserts the specified metadata records.')
    public static void upsertCustomMetadataRecord(List<MetadataRecord> customMetadataRecords) {
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();

        for(MetadataRecord record :customMetadataRecords) {
            Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
            customMetadata.fullName = 'Example.' + record.name;
            customMetadata.label = record.label;

            Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
            customField.field = 'Example_Field__c';
            customField.value = record.exampleField;
            customMetadata.values.add(customField);

            mdContainer.addMetadata(customMetadata);
        }

        Metadata.Operations.enqueueDeployment(mdContainer, null);
    }

    public class MetadataRecord {
        @InvocableVariable(label='Custom Metadata Record - Name' description='this should be in the form: ISVNamespace__MetadataTypeName.MetadataRecordName' required=true)
        public String name;
    
        @InvocableVariable(label='Custom Metadata Record - Label' description='this is required when creating a new record')
        public String label;
        
        @InvocableVariable(label='Custom Metadata Record - Example Custom Field' description='this is required when creating a new record')
        public String exampleField;  
    }
}
