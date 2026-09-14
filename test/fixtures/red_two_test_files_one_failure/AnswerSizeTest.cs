using NUnit.Framework;

public class AnswerSizeTest
{
    [Test]
    public void the_answer_is_three_digits_long()
    {
        Assert.That(new Hiker().Answer().ToString().Length, Is.EqualTo(3));
    }
}
