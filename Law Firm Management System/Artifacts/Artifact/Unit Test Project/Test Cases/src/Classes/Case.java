package Classes;

public class Case {

    private int caseID;
    private String caseType;
    private String status;

    // Constructor
    public Case(int caseID, String caseType, String status) {
        this.caseID = caseID;
        this.caseType = caseType;
        this.status = status;
    }

    // Getters
    public int getCaseID() {
        return caseID;
    }

    public String getCaseType() {
        return caseType;
    }

    public String getStatus() {
        return status;
    }
    
}
