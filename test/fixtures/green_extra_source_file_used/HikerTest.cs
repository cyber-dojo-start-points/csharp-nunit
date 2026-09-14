using NUnit.Framework;

public class HikerTest
{
    [Test]
    public void the_digits_of_the_answer_add_up_to_six()
    {
        Assert.That(new Hiker().AnswerChecksum(), Is.EqualTo(6));
    }
}
