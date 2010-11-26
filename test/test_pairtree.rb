require 'helper'

class TestPairtree < Test::Unit::TestCase
  def roundtrip s
    en = Pairtree::Identifier.encode s
    de = Pairtree::Identifier.decode en
    assert_equal(s,de)
  end
  def test_a
    assert_equal(Pairtree::Identifier.encode('a'), 'a')
    assert_equal(Pairtree::Path.id_to_path('a'), 'a')
    self.roundtrip('a')
  end

  def test_ab
    assert_equal(Pairtree::Identifier.encode('ab'), 'ab')
    assert_equal(Pairtree::Path.id_to_path('ab'), 'ab')
    self.roundtrip('ab')
  end

  def test_abc
    assert_equal(Pairtree::Identifier.encode('abc'), 'abc')
    assert_equal(Pairtree::Path.id_to_path('abc'), 'ab/c')
    self.roundtrip('abc')
  end

  def test_abcd
    assert_equal(Pairtree::Identifier.encode('abcd'), 'abcd')
    assert_equal(Pairtree::Path.id_to_path('abcd'), 'ab/cd')
    self.roundtrip('abcd')
  end

  def test_space
    assert_equal(Pairtree::Identifier.encode('hello world'), 'hello^20world')
    assert_equal(Pairtree::Path.id_to_path('hello world'), 'he/ll/o^/20/wo/rl/d')
    self.roundtrip('hello world')
  end

  def test_slash
    assert_equal(Pairtree::Identifier.encode('/'), '=')
    self.roundtrip('/')
  end

  def test_urn
    assert_equal(Pairtree::Identifier.encode('http://n2t.info/urn:nbn:se:kb:repos-1'), 'http+==n2t,info=urn+nbn+se+kb+repos-1')
    self.roundtrip('http://n2t.info/urn:nbn:se:kb:repos-1')
  end

  def test_wtf
    assert_equal(Pairtree::Identifier.encode('what-the-*@?#!^!?'), "what-the-^2a@^3f#!^5e!^3f")
    self.roundtrip('what-the-*@?#!^!?')
  end

  def test_weird
     assert_equal(Pairtree::Identifier.encode('\\"*+,<=>?^|'), "^5c^22^2a^2b^2c^3c^3d^3e^3f^5e^7c")
     assert_equal(Pairtree::Path.id_to_path('\\"*+,<=>?^|'), "^5/c^/22/^2/a^/2b/^2/c^/3c/^3/d^/3e/^3/f^/5e/^7/c")
  end

  def test_hardcore_unicode
    self.roundtrip("   1. Euro Symbol: €.
   2. Greek: Μπορώ να φάω σπασμένα γυαλιά χωρίς να πάθω τίποτα.
   3. Íslenska / Icelandic: Ég get etið gler án þess að meiða mig.
   4. Polish: Mogę jeść szkło, i mi nie szkodzi.
   5. Romanian: Pot să mănânc sticlă și ea nu mă rănește.
   6. Ukrainian: Я можу їсти шкло, й воно мені не пошкодить.
   7. Armenian: Կրնամ ապակի ուտել և ինծի անհանգիստ չըներ։
   8. Georgian: მინას ვჭამ და არა მტკივა.
   9. Hindi: मैं काँच खा सकता हूँ, मुझे उस से कोई पीडा नहीं होती.
  10. Hebrew(2): אני יכול לאכול זכוכית וזה לא מזיק לי.
  11. Yiddish(2): איך קען עסן גלאָז און עס טוט מיר נישט װײ.
  12. Arabic(2): أنا قادر على أكل الزجاج و هذا لا يؤلمني.
  13. Japanese: 私はガラスを食べられます。それは私を傷つけません。
  14. Thai: ฉันกินกระจกได้ แต่มันไม่ทำให้ฉันเจ็บ ")
  end

  def test_french
    self.roundtrip 'Années de Pèlerinage'
    self.roundtrip "Années de Pèlerinage (Years of Pilgrimage) (S.160, S.161,\n\
 S.163) is a set of three suites by Franz Liszt for solo piano. Liszt's\n\
 complete musical style is evident in this masterwork, which ranges from\n\
 virtuosic fireworks to sincerely moving emotional statements. His musical\n\
 maturity can be seen evolving through his experience and travel. The\n\
 third volume is especially notable as an example of his later style: it\n\
 was composed well after the first two volumes and often displays less\n\
 showy virtuosity and more harmonic experimentation."
  end            
  



end
