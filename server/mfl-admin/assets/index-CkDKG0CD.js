import{B as e,s as l,o as i,c as o,l as p,m as s}from"./index-Daypqzai.js";var r=function(n){var a=n.dt;return`
.p-iftalabel {
    display: block;
    position: relative;
}

.p-iftalabel label {
    position: absolute;
    pointer-events: none;
    top: `.concat(a("iftalabel.top"),`;
    transition-property: all;
    transition-timing-function: ease;
    line-height: 1;
    font-size: `).concat(a("iftalabel.font.size"),`;
    font-weight: `).concat(a("iftalabel.font.weight"),`;
    inset-inline-start: `).concat(a("iftalabel.position.x"),`;
    color: `).concat(a("iftalabel.color"),`;
    transition-duration: `).concat(a("iftalabel.transition.duration"),`;
}

.p-iftalabel .p-inputtext,
.p-iftalabel .p-textarea,
.p-iftalabel .p-select-label,
.p-iftalabel .p-multiselect-label,
.p-iftalabel .p-autocomplete-input-multiple,
.p-iftalabel .p-cascadeselect-label,
.p-iftalabel .p-treeselect-label {
    padding-block-start: `).concat(a("iftalabel.input.padding.top"),`;
    padding-block-end: `).concat(a("iftalabel.input.padding.bottom"),`;
}

.p-iftalabel:has(.p-invalid) label {
    color: `).concat(a("iftalabel.invalid.color"),`;
}

.p-iftalabel:has(input:focus) label,
.p-iftalabel:has(input:-webkit-autofill) label,
.p-iftalabel:has(textarea:focus) label,
.p-iftalabel:has(.p-inputwrapper-focus) label {
    color: `).concat(a("iftalabel.focus.color"),`;
}

.p-iftalabel .p-inputicon {
    top: `).concat(a("iftalabel.input.padding.top"),`;
    transform: translateY(25%);
    margin-top: 0;
}
`)},c={root:"p-iftalabel"},f=e.extend({name:"iftalabel",theme:r,classes:c}),b={name:"BaseIftaLabel",extends:l,style:f,provide:function(){return{$pcIftaLabel:this,$parentInstance:this}}},d={name:"IftaLabel",extends:b,inheritAttrs:!1};function u(t,n,a,m,h,v){return i(),o("span",s({class:t.cx("root")},t.ptmi("root")),[p(t.$slots,"default")],16)}d.render=u;export{d as s};
