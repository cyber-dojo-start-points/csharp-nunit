using NUnit.Framework;

public class HikerTest
{
    [Test]
    public void life_the_universe_and_everything()
    {
        Assert.That(new Hiker().Answer(), Is.EqualTo(42));
    }

    [Test]
    public void the_answer_is_a_multiple_of_seven()
    {
        Assert.That(new Hiker().Answer() % 7, Is.EqualTo(0));
    }

    [Test]
    public void the_answer_is_three_digits_long()
    {
        Assert.That(new Hiker().Answer().ToString().Length, Is.EqualTo(3));
    }
}
