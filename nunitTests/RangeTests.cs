using NUnit.Framework;
using api.Controllers;
using System.Linq;


namespace Tests
{
    public class Tests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void Test1()
        {
            var range = new Range{ Count = 3};
            var generated = range.Of(() => "");
            Assert.AreEqual(3, generated.Count());
            
        }
    }
}