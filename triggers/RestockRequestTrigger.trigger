trigger RestockRequestTrigger on Re_Plastic_Innovations_Restock_Request__c (after update) {
    List<Re_Plastic_Innovations_Restock_Request__c> approvedList = new List<Re_Plastic_Innovations_Restock_Request__c>();

    for (Re_Plastic_Innovations_Restock_Request__c req : Trigger.new) {
        Re_Plastic_Innovations_Restock_Request__c oldReq = Trigger.oldMap.get(req.Id);
        if (req.Status__c == 'Approved' && oldReq.Status__c != 'Approved') {
            approvedList.add(req);
        }
    }

    if (!approvedList.isEmpty()) {
        InventoryManager.processRestockApproval(approvedList); // Update stock
        EmailNotificationHelper.sendRestockNotification(approvedList); // Send email
    }
}
