import Classes.Client;
import Classes.Case;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;


public class JUnitTest {

    Client client;

    @Before
    public void setUp() {
        System.out.println("It is run before the test is run");
        // Initialize the objects needed for the tests
        client = new Client(1, "John Doe", "john@example.com", "123 Elm Street");
    }

    @After
    public void tearDown() {
        System.out.println("It is run after the test is run");
        // Clean up resources after tests
        client = null;
    }

    @Test
    public void testClientCreation() {
        assertNotNull("Client object should not be null", client);
    }

    @Test
    public void testClientSetAndGetName() {
        client.setName("Jane Doe");
        assertEquals("Name should be Jane Doe", "Jane Doe", client.getName());
    }

    @Test
    public void testClientWithCases() {
        Case case1 = new Case(101, "Civil", "Open");
        Case case2 = new Case(102, "Criminal", "Closed");
        client.addCase(case1);
        client.addCase(case2);
        assertEquals("Client should have 2 cases", 2, client.getCases().size());
    }
}

