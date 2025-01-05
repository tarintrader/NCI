package Classes;

import java.util.ArrayList;
import java.util.List;

public class Client {

    private int clientID;
    private String name;
    private String email;
    private String address;
    private List<Case> cases;

    // Constructor
    public Client(int clientID, String name, String email, String address) {
        this.clientID = clientID;
        this.name = name;
        this.email = email;
        this.address = address;
        this.cases = new ArrayList<>(); // Initialize the cases list.
    }

    // Getter and Setter for Name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Methods to Manage Cases
    public void addCase(Case newCase) {
        cases.add(newCase);
    }

    public List<Case> getCases() {
        return cases;
    }
    
}