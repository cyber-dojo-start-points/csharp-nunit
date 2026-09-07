using Moq;
using NSubstitute;
using NUnit.Framework;

public class HikerTest
{
    // For exposition, once with Moq and once with NSubstitute.

    [Test]
    public void answer_is_logged_verified_with_moq()
    {
        var logger = new Mock<ILogger>();

        var answer = new Hiker(logger.Object).Answer();

        Assert.That(answer, Is.EqualTo(42));
        logger.Verify(l => l.Log("the answer is 42"), Times.Once);
    }

    [Test]
    public void answer_is_logged_verified_with_nsubstitute()
    {
        var logger = Substitute.For<ILogger>();

        var answer = new Hiker(logger).Answer();

        Assert.That(answer, Is.EqualTo(42));
        logger.Received(1).Log("the answer is 42");
    }
}
