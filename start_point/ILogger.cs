// Moq and NSubstitute can only mock an interface or a virtual member, so a
// collaborator you want to mock has to be one of those. This one is an
// interface, which is why Hiker can be handed a mock of it in a test.
public interface ILogger
{
    void Log(string message);
}
