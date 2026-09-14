using NUnit.Framework;

public class HikerTest
{
    [Test]
    public void life_the_universe_and_everything()
    {
        Assert.That(new Hiker().Answer(), Is.EqualTo(42));
    }

    [Test]
    public void the_answer_is_two_digits_long()
    {
        Assert.That(new Hiker().AnswerSize(), Is.EqualTo(2));
    }
}
