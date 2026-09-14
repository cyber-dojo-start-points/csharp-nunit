using NUnit.Framework;

public class HikerTest
{
    [Test]
    public void life_the_universe_and_everything()
    {
        Assert.That(new Hiker().Ansewr(), Is.EqualTo(42));
    }
}
