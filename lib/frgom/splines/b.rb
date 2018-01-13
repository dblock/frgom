module Frgom
  module Splines
    class B
      def reticulated?
        !!@reticulated
      end

      def reticulate!
        @reticulated = true
      end
    end
  end
end
