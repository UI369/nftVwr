/*// Get the modal
var modal = document.getElementById("modal-content");

// Get the button that opens the modal
var btn = document.getElementById("modal-button");

// Get the <span> element that closes the modal
var span = document.getElementById("modal-close");

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  console.log("close clicked");
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}



function outsideClick(e) {
  console.log(e);
  if(e.target.id == "modal-button"){
    var event = new Event("modalButtonClicked");
    console.dir(document.getElementById("modal-text"));
    event.data = document.getElementById("modal-text").value;
    console.log('dispatching event');
    console.dir(event);
    document.dispatchEvent(event);
  }
  if (e.target.closest(".modal-inner")) { 
    return;
  }
  const modalVisible = document.querySelector(".modal-visible");
  if (modalVisible) {
    closeModal();
  }
}
function escKey(evt) {
  var isEscape = false;
  if ("key" in evt) {
      isEscape = (evt.key === "Escape" || evt.key === "Esc");
  } else {
      isEscape = (evt.keyCode === 27);
  }
  if (isEscape) {
    closeModal();
  }
}

function closeClick(e) {
  console.log('closeClick');
  if (e.target.classList.contains("closeModal")) {
    closeModal();
  }
}
function trapTabKey(e) {

  let isTabPressed = e.key === 'Tab' || e.keyCode === 9;

  if (!isTabPressed) {
    return;
  }

  const vanillaModal = document.querySelector(".vanilla-modal");
  const FOCUSABLE_ELEMENTS = [
    "a[href]",
    "area[href]",
    'input:not([disabled]):not([type="hidden"]):not([aria-hidden])',
    "select:not([disabled]):not([aria-hidden])",
    "textarea:not([disabled]):not([aria-hidden])",
    "button:not([disabled]):not([aria-hidden])",
    "iframe",
    "object",
    "embed",
    "[contenteditable]",
    '[tabindex]:not([tabindex^="-"])',
  ];

  const nodes = vanillaModal.querySelectorAll(FOCUSABLE_ELEMENTS);
  let focusableNodes = Array(...nodes);

  if (focusableNodes.length === 0) return;

  focusableNodes = focusableNodes.filter((node) => {
    return node.offsetParent !== null;
  });

  // if disableFocus is true
  if (!vanillaModal.contains(document.activeElement)) {
    focusableNodes[0].focus();
  } else {
    const focusedItemIndex = focusableNodes.indexOf(document.activeElement);

    if (e.shiftKey && focusedItemIndex === 0) {
      focusableNodes[focusableNodes.length - 1].focus();
      e.preventDefault();
    }

    if (
      !e.shiftKey &&
      focusableNodes.length > 0 &&
      focusedItemIndex === focusableNodes.length - 1
    ) {
      focusableNodes[0].focus();
      e.preventDefault();
    }
  }
}

function closeModal() {
  const vanillaModal = document.querySelector(".vanilla-modal");
  if (vanillaModal) {
    vanillaModal.classList.remove("modal-visible");
    document.getElementById("modal-content").innerHTML = "";
    document.getElementById("modal-content").style = "";
  }

  document.removeEventListener("keydown", escKey, false);
  //document.removeEventListener("click", outsideClick, true);
  //document.removeEventListener("click", closeClick);
  document.removeEventListener("keydown", trapTabKey, false);
}

const modal = {
  init: function () {
    const prerendredModal = document.createElement("div");
    prerendredModal.classList.add("vanilla-modal");
    const htmlModal = `         
       <div class="modal">
       <div class="modal-inner"
       ><div id="modal-content"></div></div></div>`;
    prerendredModal.innerHTML = htmlModal;
    document.body.appendChild(prerendredModal);
  },
  open: function (idContent, option = { default: null }) {
    let vanillaModal = document.querySelector(".vanilla-modal");
    if (!vanillaModal) {
      console.log("there is no vanilla modal class");
      modal.init();
      vanillaModal = document.querySelector(".vanilla-modal");
    }

    const content = document.getElementById(idContent);
    let currentModalContent = content.cloneNode(true);
    currentModalContent.classList.add("current-modal");
    currentModalContent.style = "";
    document.getElementById("modal-content").appendChild(currentModalContent);

    if (!option.default) {
      if (option.width && option.height) {
        document.getElementById("modal-content").style.width = option.width;
        document.getElementById("modal-content").style.height = option.height;
      }
    }
    vanillaModal.classList.add("modal-visible");
   // document.addEventListener("click", outsideClick, true);
    document.addEventListener("keydown", escKey);
    document.addEventListener("keydown", trapTabKey);
    //document.getElementById("modal-content").addEventListener("click", closeClick, true);
  },

  close: function () {
    closeModal();
  },
};

// for webpack es6 use uncomment the next line
// export default modal;
*/