# Display github gists easily anywhere liquid syntax is parsed (templates, includes, posts/pages).
# 
# Usage: {% gist 3361948/sample_output %}
# 
# Copyright (c) 2012, Xorcode LLC.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met: 
# 
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer. 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution. 
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# The views and conclusions contained in the software and documentation are those
# of the authors and should not be interpreted as representing official policies, 
# either expressed or implied, of Xorcode, LLC.

module Xorcode
  module Liquid
    class GistTag < ::Liquid::Tag
      def initialize(tag_name, gist_ref, tokens)
        @gist_ref = gist_ref.strip
        @gist_id, @filename = @gist_ref.split('/')
        super
      end

      def render(context)
        script_uri = "https://gist.github.com/#{@gist_id}.js?file=#{@filename}"
        <<MARKUP.strip
<div id="gist-#{@gist_ref.gsub(/[^a-z0-9]/i,'-')}">
  <script src="#{script_uri}"></script>
</div>
MARKUP
      end
    end
  end
end

Liquid::Template.register_tag('gist', Xorcode::Liquid::GistTag)

