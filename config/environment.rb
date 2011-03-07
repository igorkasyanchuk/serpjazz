# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RailsjazzCom::Application.initialize!


ENV['RECAPTCHA_PUBLIC_KEY']  = '6Lcf3L4SAAAAAGucx4zccJDUE1_Ct0Zn2RiSSqwI'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6Lcf3L4SAAAAAIuvB6nr0lslV_Tuoz2FYbShhuGi'

#ENV['RECAPTCHA_PUBLIC_KEY']  = '6Lce3L4SAAAAAGwkSXbK3Ffycn1Sq4HzYi3OnsfQ'
#ENV['RECAPTCHA_PRIVATE_KEY'] = '6Lce3L4SAAAAALa5v7x6CDP_iSEO0gzASn3DklRA'
